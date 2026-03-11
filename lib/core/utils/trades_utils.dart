import '../../data/models/trade.dart';

class TradesUtils {
  final List<Trade> _trades;

  TradesUtils({required List<Trade> trades}) : _trades = trades;

  int get tradesLength => _trades.length;

  double get avgTrade => _trades.isEmpty
      ? 0
      : _trades.fold(0.0, (s, t) => s + t.totalPrice) / _trades.length;

  double get maxTrade => _trades.isEmpty
      ? 0
      : _trades.map((t) => t.totalPrice).reduce((a, b) => a > b ? a : b);

  int get trades7d {
    final date = DateTime.now().subtract(const Duration(days: 7));
    return _trades.where((t) => t.createdAt.isAfter(date)).length;
  }

  double get spent7d {
    final date = DateTime.now().subtract(const Duration(days: 7));
    return _trades
        .where((t) => t.createdAt.isAfter(date))
        .fold(0.0, (s, t) => s + t.totalPrice);
  }

  int get trades24h {
    final d = DateTime.now().subtract(const Duration(hours: 24));
    return _trades.where((t) => t.createdAt.isAfter(d)).length;
  }

  double get spent24h {
    final d = DateTime.now().subtract(const Duration(hours: 24));
    return _trades
        .where((t) => t.createdAt.isAfter(d))
        .fold(0.0, (s, t) => s + t.totalPrice);
  }

  int get coins7d {
    final d = DateTime.now().subtract(const Duration(days: 7));
    return _trades
        .where((t) => t.createdAt.isAfter(d))
        .fold(0, (sum, t) => sum + t.amount);
  }

  int get coins24h {
    final d = DateTime.now().subtract(const Duration(hours: 24));
    return _trades
        .where((t) => t.createdAt.isAfter(d))
        .fold(0, (sum, t) => sum + t.amount);
  }

  DateTime? get firstTrade {
    if (_trades.isEmpty) return null;
    final sorted = List<Trade>.from(_trades)
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return sorted.first.createdAt;
  }

  DateTime? get lastTrade {
    if (_trades.isEmpty) return null;
    final sorted = List<Trade>.from(_trades)
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return sorted.last.createdAt;
  }
}
