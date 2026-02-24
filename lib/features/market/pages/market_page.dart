import 'package:Bitmark/app/router/app_router.dart';
import 'package:Bitmark/app/widgets/search_field.dart';
import 'package:auto_route/auto_route.dart';
import 'package:Bitmark/app/widgets/coin_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/widgets/loader.dart';
import '../../../app/widgets/settings_button.dart';
import '../../../app/widgets/unknown_error.dart';
import '../../../core/utils/extensions.dart';
import '../../../generated/l10n.dart';
import '../providers/filter_providers.dart';
import '../providers/filtered_coins_provider.dart';
import '../providers/market_provider.dart';
import '../widgets/market_sort_sheet.dart';

@RoutePage()
class MarketPage extends ConsumerStatefulWidget {
  const MarketPage({super.key});

  @override
  ConsumerState createState() => _MarketPageState();
}

class _MarketPageState extends ConsumerState<MarketPage> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final text = ref.read(searchCoinsProvider);
    if (_searchController.text != text) {
      _searchController.text = text;
    }
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 500) {
      ref.read(marketNotifierProvider.notifier).getCryptoCoins();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cryptoCoinsP = ref.watch(filteredCoinsProvider);
    final s = S.of(context);
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            automaticallyImplyLeading: false,
            title: Text(s.market),
            actions: [
              IconButton(
                onPressed: () => context.pushRoute(const SearchCoinsRoute()),
                icon: const Icon(Icons.search),
              ),
              const SettingsButton(),
            ],
            bottom: PreferredSize(
              preferredSize: .fromHeight(62.sp),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 12.sp,
                  right: 12.sp,
                  bottom: 12.sp,
                ),
                child: _SearchAndFilterRow(searchController: _searchController),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(16.sp),
            sliver: cryptoCoinsP.when(
              data: (coins) {
                return coins.isNotEmpty
                    ? SliverList.builder(
                        itemCount: coins.length,
                        itemBuilder: (context, index) {
                          final coin = coins[index];
                          return CoinCard(coin: coin.coin, price: coin.price);
                        },
                      )
                    : SliverFillRemaining(
                        child: _EmptyList(searchController: _searchController),
                      );
              },
              loading: () => const SliverFillRemaining(child: Loader()),
              error: (_, _) => SliverFillRemaining(
                child: UnknownError(
                  onPressed: () => ref
                      .read(marketNotifierProvider.notifier)
                      .getCryptoCoins(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyList extends ConsumerWidget {
  final TextEditingController searchController;

  const _EmptyList({required this.searchController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final s = S.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(s.coins_not_found, style: theme.textTheme.displayLarge),
        TextButton(
          onPressed: () {
            ref.read(searchCoinsProvider.notifier).update((state) => '');
            searchController.clear();
          },
          child: Text(s.reset_search),
        ),
      ],
    );
  }
}

class _SearchAndFilterRow extends ConsumerWidget {
  final TextEditingController searchController;

  const _SearchAndFilterRow({required this.searchController});

  void update(WidgetRef ref, String text) =>
      ref.read(searchCoinsProvider.notifier).update((state) => text);

  void showMarketFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => const MarketSortSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: SearchField(
            controller: searchController,
            reset: () {
              searchController.clear();
              update(ref, '');
            },
            onChanged: (text) => update(ref, text),
          ),
        ),
        IconButton(
          onPressed: () => showMarketFilters(context),
          icon: const Icon(Icons.more_vert),
        ),
      ],
    );
  }
}
