import 'package:Bitmark/app/router/app_router.dart';
import 'package:Bitmark/features/market/providers/sort_market_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:Bitmark/app/widgets/coin_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/widgets/loader.dart';
import '../../../app/widgets/settings_button.dart';
import '../../../app/widgets/unknown_error.dart';
import '../../../core/utils/dialog_helper.dart';
import '../../../core/utils/toast_helper.dart';
import '../../../generated/l10n.dart';
import '../providers/compare_coins_provider.dart';
import '../providers/market_provider.dart';
import '../widgets/market_sort_sheet.dart';

@RoutePage()
class MarketPage extends ConsumerStatefulWidget {
  const MarketPage({super.key});

  @override
  ConsumerState createState() => _MarketPageState();
}

class _MarketPageState extends ConsumerState<MarketPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (isFromCompare(context)) {
      ref.listenManual(compareCoinsNotifierProvider, (_, state) {
        state.when(
          data: (_) {
            context.pop();
            context.pop();
          },
          error: (_, _) {
            context.pop();
            ToastHelper.unknownError();
          },
          loading: () => DialogHelper.loading(context),
        );
      });
    }
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 500) {
      ref.read(marketNotifierProvider.notifier).getCryptoCoins();
    }
  }

  bool isFromCompare(BuildContext context) {
    final stack = context.router.stack;
    return stack.length >= 2 &&
        stack[stack.length - 2].name == CompareCoinsRoute.name;
  }

  void getCoins(WidgetRef ref) {
    ref.read(sortMarketProvider.notifier).update((state) => .marketCap);
    ref.read(marketNotifierProvider.notifier).getCryptoCoins();
  }

  void showMarketFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => const MarketSortSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cryptoCoinsP = ref.watch(marketNotifierProvider);
    final s = S.of(context);
    final fromCompare = isFromCompare(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: fromCompare,
        title: Text(s.market),
        leading: !fromCompare
            ? IconButton(
                onPressed: () => context.pushRoute(const SearchCoinsRoute()),
                icon: const Icon(Icons.search),
              )
            : null,
        actions: [
          fromCompare
              ? IconButton(
                  onPressed: () => showMarketFilters(context),
                  icon: const Icon(Icons.swap_vert),
                )
              : PopupMenuButton<MarketPopup>(
                  icon: const Icon(Icons.more_vert),
                  onSelected: (value) => switch (value) {
                    .sort => showMarketFilters(context),
                    .compare => context.pushRoute(const CompareCoinsRoute()),
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(value: .sort, child: Text(s.sort)),
                    PopupMenuItem(value: .compare, child: Text(s.compare)),
                  ],
                ),
          if (!fromCompare) const SettingsButton(),
        ],
      ),
      body: Padding(
        padding: .all(16.sp),
        child: cryptoCoinsP.when(
          data: (coins) => ListView.builder(
            controller: _scrollController,
            itemCount: coins.length,
            itemBuilder: (context, index) {
              final coin = coins[index];
              return CoinCard(coin: coin.coin, price: coin.price);
            },
          ),
          loading: () => const Loader(),
          error: (e, _) =>
              UnknownError(onPressed: () => getCoins(ref), error: e),
        ),
      ),
    );
  }
}

enum MarketPopup { sort, compare }
