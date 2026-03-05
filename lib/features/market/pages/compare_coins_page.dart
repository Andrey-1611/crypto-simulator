import 'package:Bitmark/app/router/app_router.dart';
import 'package:Bitmark/app/widgets/coin_card.dart';
import 'package:Bitmark/app/widgets/loader.dart';
import 'package:Bitmark/app/widgets/unknown_error.dart';
import 'package:Bitmark/data/models/price_point.dart';
import 'package:Bitmark/features/market/providers/compare_coins_provider.dart';
import 'package:Bitmark/generated/l10n.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/widgets/size_box.dart';
import '../../../core/utils/extensions.dart';
import '../../../data/models/coin_full_data.dart';

@RoutePage()
class CompareCoinsPage extends ConsumerWidget {
  const CompareCoinsPage({super.key});

  void dismiss(WidgetRef ref, String coinSymbol) =>
      ref.read(compareCoinsNotifierProvider.notifier).removeCoin(coinSymbol);

  void removeAll(WidgetRef ref) =>
      ref.read(compareCoinsNotifierProvider.notifier).removeAll();

  void changePeriod(WidgetRef ref, CompareCoinsPeriod period) =>
      ref.read(compareCoinsNotifierProvider.notifier).changePeriod(period);

  void changeType(WidgetRef ref, LineChartType type) =>
      ref.read(lineChartTypeProvider.notifier).state = type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final compareCoinsP = ref.watch(compareCoinsNotifierProvider);
    final s = S.of(context);
    final theme = context.theme;
    return Scaffold(
      appBar: AppBar(
        title: Text(s.compare_coins),
        actions: [
          PopupMenuButton<CompareCoinsPopup>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) => switch (value) {
              .add => context.pushRoute(const MarketRoute()),
              .search => context.pushRoute(const SearchCoinsRoute()),
              .deleteAll => removeAll(ref),
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: .add, child: Text(s.add)),
              PopupMenuItem(value: .search, child: Text(s.search)),
              PopupMenuItem(value: .deleteAll, child: Text(s.reset)),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: .all(16.sp),
        child: Center(
          child: compareCoinsP.when(
            data: (coins) => coins.isNotEmpty
                ? Column(
                    children: [
                      SegmentedButton<CompareCoinsPeriod>(
                        segments: const [
                          ButtonSegment(value: .week, label: Text('1W')),
                          ButtonSegment(value: .month, label: Text('1M')),
                          ButtonSegment(value: .threeMonths, label: Text('3M')),
                          ButtonSegment(value: .sixMonths, label: Text('6M')),
                          ButtonSegment(value: .year, label: Text('1Y')),
                        ],
                        selected: {ref.watch(compareCoinsPeriodProvider)},
                        onSelectionChanged: (period) =>
                            changePeriod(ref, period.first),
                      ),
                      const SizeBox(height: 0.01),
                      SegmentedButton<LineChartType>(
                        segments: [
                          ButtonSegment(value: .price, label: Text(s.price_p)),
                          ButtonSegment(
                            value: .percentChange,
                            label: Text(s.change_pct),
                          ),
                        ],
                        selected: {ref.watch(lineChartTypeProvider)},
                        onSelectionChanged: (type) =>
                            changeType(ref, type.first),
                      ),
                      const SizeBox(height: 0.01),
                      SizeBox(
                        height: 0.25,
                        child: coins.isNotEmpty
                            ? _CompareCoinsChart(coins: coins)
                            : const SizedBox.shrink(),
                      ),
                      const SizeBox(height: 0.02),
                      Expanded(
                        child: ListView.builder(
                          itemCount: coins.length,
                          itemBuilder: (context, index) {
                            final coin = coins[index].coin;
                            return Dismissible(
                              key: ValueKey(coin),
                              onDismissed: (_) =>
                                  dismiss(ref, coin.info.symbol),
                              child: Row(
                                children: [
                                  _ChartRound(index: index),
                                  Expanded(
                                    child: CoinCard(
                                      coin: coin.info,
                                      price: coin.priceData.price,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : Text(
                    s.start_searching_coins,
                    style: theme.textTheme.displayLarge,
                  ),
            error: (e, _) => UnknownError(error: e),
            loading: () => const Loader(),
          ),
        ),
      ),
    );
  }
}

class _ChartRound extends StatelessWidget {
  final int index;

  const _ChartRound({required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.sp,
      height: 24.sp,
      decoration: BoxDecoration(
        shape: .circle,
        color: ColorRandom.random(index),
      ),
    );
  }
}

enum CompareCoinsPopup { add, search, deleteAll }

class _CompareCoinsChart extends ConsumerWidget {
  final List<CoinFullData> coins;

  const _CompareCoinsChart({required this.coins});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final type = ref.watch(lineChartTypeProvider);
    final allSpots = coins
        .expand((c) => PricePoint.getCoinSpots(c, type).map((p) => p.y))
        .toList();
    final minY = allSpots.reduce((a, b) => a < b ? a : b) * 0.9;
    final maxY = allSpots.reduce((a, b) => a > b ? a : b) * 1.1;
    return LineChart(
      LineChartData(
        minY: minY,
        maxY: maxY,
        lineBarsData: coins.asMap().entries.map((entry) {
          final spots = PricePoint.getCoinSpots(entry.value, type);
          return LineChartBarData(
            spots: spots,
            isCurved: true,
            dotData: const FlDotData(show: false),
            barWidth: 2,
            color: ColorRandom.random(entry.key),
          );
        }).toList(),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            fitInsideHorizontally: true,
            fitInsideVertically: true,
            getTooltipItems: (spots) => spots
                .map(
                  (spot) => LineTooltipItem(
                    type == .price ? spot.y.price4 : spot.y.percent,
                    theme.textTheme.bodyLarge!,
                  ),
                )
                .toList(),
          ),
        ),
        titlesData: const FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
      ),
    );
  }
}
