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
}
