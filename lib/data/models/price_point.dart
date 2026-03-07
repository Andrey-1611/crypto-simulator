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

  static List<FlSpot> getCoinSpots(CoinFullData coin, LineChartType type) {
    return switch (type) {
      .price =>
        coin.prices
            .map(
              (p) => FlSpot(p.time.millisecondsSinceEpoch.toDouble(), p.close),
            )
            .toList(),
      .percentChange =>
        coin.prices
            .map(
              (p) => FlSpot(
                p.time.millisecondsSinceEpoch.toDouble(),
                ((p.close - coin.prices.first.close) /
                        coin.prices.first.close) *
                    100,
              ),
            )
            .toList(),
    };
  }
}
