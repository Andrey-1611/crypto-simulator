import 'package:auto_route/auto_route.dart';
import 'package:crypto_simulator/app/widgets/crypto_coin_card.dart';
import 'package:crypto_simulator/data/models/crypto_coin_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/widgets/loader.dart';
import '../../../app/widgets/settings_button.dart';
import '../../../app/widgets/unknown_error.dart';
import '../../../generated/l10n.dart';
import '../providers/filter_providers.dart';
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
    final cryptoCoinsP = ref.watch(marketNotifierProvider);
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: _AppBar(
        size: Size.fromHeight(size.height * 0.13),
        searchController: _searchController,
      ),
      body: Padding(
        padding: const .all(16.0),
        child: Center(
          child: cryptoCoinsP.when(
            data: (coins) {
              final filterCoins = CryptoCoinDetails.filterCryptoCoins(
                coins,
                ref.watch(sortCoinsProvider),
                ref.watch(searchCoinsProvider),
              );
              return filterCoins.isNotEmpty
                  ? RefreshIndicator(
                      onRefresh: () => ref
                          .read(marketNotifierProvider.notifier)
                          .updateCoinsPrices(),
                      child: _CryptoCoinsList(
                        coins: filterCoins,
                        scrollController: _scrollController,
                      ),
                    )
                  : _EmptyList(searchController: _searchController);
            },
            error: (_, _) => UnknownError(
              onPressed: () =>
                  ref.read(marketNotifierProvider.notifier).getCryptoCoins(),
            ),
            loading: () => const Loader(),
          ),
        ),
      ),
    );
  }
}

class _CryptoCoinsList extends ConsumerWidget {
  final List<CryptoCoinDetails> coins;
  final ScrollController scrollController;

  const _CryptoCoinsList({required this.coins, required this.scrollController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      controller: scrollController,
      itemCount: coins.length,
      itemBuilder: (context, index) {
        final coin = coins[index];
        return CryptoCoinCard(coin: coin, price: coin.currentPrice);
      },
    );
  }
}

class _EmptyList extends ConsumerWidget {
  final TextEditingController searchController;

  const _EmptyList({required this.searchController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Монет не найдено', style: theme.textTheme.displayLarge),
        TextButton(
          onPressed: () {
            ref.read(searchCoinsProvider.notifier).update((state) => '');
            searchController.clear();
          },
          child: const Text('Сбросить поиск'),
        ),
      ],
    );
  }
}

class _AppBar extends ConsumerWidget implements PreferredSizeWidget {
  final Size size;
  final TextEditingController searchController;

  const _AppBar({required this.size, required this.searchController});

  void update(String text, WidgetRef ref) {
    ref.read(searchCoinsProvider.notifier).update((state) => text);
  }

  void showMarketFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => const MarketSortSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final theme = Theme.of(context);
    return AppBar(
      title: Text(s.market),
      actions: [const SettingsButton()],
      automaticallyImplyLeading: false,
      bottom: PreferredSize(
        preferredSize: preferredSize,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchController,
                  textInputAction: TextInputAction.search,
                  onChanged: (text) => update(text, ref),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Поиск...',
                    filled: true,
                    fillColor: theme.scaffoldBackgroundColor,
                    suffixIcon: IconButton(
                      onPressed: () {
                        searchController.clear();
                        update('', ref);
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () => showMarketFilters(context),
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => size;
}
