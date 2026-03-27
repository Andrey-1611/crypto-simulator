import 'package:Bitmark/app/router/app_router.dart';
import 'package:Bitmark/core/utils/extensions.dart';
import 'package:Bitmark/features/market/providers/sort_market_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:Bitmark/app/widgets/coin_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/widgets/settings_button.dart';
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
    if (context.fromRoute(const CompareCoinsRoute())) {
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

  Future<void> refresh() async =>
      ref.read(marketNotifierProvider.notifier).updateCoinsPrices();

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final needToSelect =
        context.fromRoute(const CompareCoinsRoute()) ||
        context.fromRoute(const TradesSimulatorRoute());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: needToSelect,
        title: Text(s.market),
        leading: !needToSelect
            ? IconButton(
                onPressed: () => context.pushRoute(const SearchCoinsRoute()),
                icon: const Icon(Icons.search),
              )
            : null,
        actions: [
          needToSelect
              ? IconButton(
                  onPressed: () => showMarketFilters(context),
                  icon: const Icon(Icons.swap_vert),
                )
              : PopupMenuButton<MarketPopup>(
                  icon: const Icon(Icons.more_vert),
                  onSelected: (value) => switch (value) {
                    .sort => showMarketFilters(context),
                    .compare => context.pushRoute(const CompareCoinsRoute()),
                    .simulator => context.pushRoute(
                      const TradesSimulatorRoute(),
                    ),
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(value: .sort, child: Text(s.sort)),
                    PopupMenuItem(value: .compare, child: Text(s.compare)),
                    const PopupMenuItem(
                      value: .simulator,
                      child: Text('Симулятор'),
                    ),
                  ],
                ),
          if (!needToSelect) const SettingsButton(),
        ],
      ),
      body: Padding(
        padding: .all(16.sp),
        child: ref.watchWhen(
          marketNotifierProvider,
          builder: (coins) => RefreshIndicator(
            onRefresh: refresh,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: coins.length,
              itemBuilder: (context, index) {
                final coin = coins[index];
                return CoinCard(coin: coin.coin, price: coin.price);
              },
            ),
          ),
        ),
      ),
    );
  }
}

enum MarketPopup { sort, compare, simulator }
