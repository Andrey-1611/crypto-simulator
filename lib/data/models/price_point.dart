import 'package:fl_chart/fl_chart.dart';

import '../../features/market/providers/compare_coins_provider.dart';
import 'coin_full_data.dart';

class PricePoint {
  final DateTime time;
  final double open;
  final double high;
  final double low;
  final double close;

  PricePoint({
    required this.time,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });

  factory PricePoint.fromApi(Map<String, dynamic> json) {
    return PricePoint(
      time: DateTime.fromMillisecondsSinceEpoch(json['time'] * 1000),
      open: (json['open'] as num).toDouble(),
      high: (json['high'] as num).toDouble(),
      low: (json['low'] as num).toDouble(),
      close: (json['close'] as num).toDouble(),
    );
  }

  static List<FlSpot> getCoinSpots(
    CoinFullData coin,
    LineChartType type,
    CompareCoinsPeriod period,
  ) {
    final prices = period.days >= 90 ? coin.dailyPrices : coin.hourlyPrices;
    return switch (type) {
      .price =>
        prices
            .map(
              (p) => FlSpot(p.time.millisecondsSinceEpoch.toDouble(), p.close),
            )
            .toList(),
      .percentChange =>
        prices
            .map(
              (p) => FlSpot(
                p.time.millisecondsSinceEpoch.toDouble(),
                100 +
                    ((p.close - prices.first.close) / prices.first.close) * 100,
              ),
            )
            .toList(),
    };
  }
}
