import 'package:Bitmark/data/models/crypto_coin.dart';
import 'package:Bitmark/features/history/providers/sort_trades_provider.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../features/history/providers/filter_trades_provider.dart';

part 'trade.g.dart';

@JsonSerializable(explicitToJson: true)
class Trade {
  final String id;
  final CryptoCoin coin;
  final double coinPrice;
  final int amount;
  final TradeType type;
  final DateTime createdAt;

  const Trade({
    required this.id,
    required this.coinPrice,
    required this.amount,
    required this.type,
    required this.createdAt,
    required this.coin,
  });

  double get totalPrice => coinPrice * amount;

  Map<String, dynamic> toJson() => _$TradeToJson(this);

  factory Trade.fromJson(Map<String, dynamic> json) => _$TradeFromJson(json);

  factory Trade.create({
    required CryptoCoin coin,
    required double coinPrice,
    required int amount,
    required TradeType type,
  }) {
    return Trade(
      id: const Uuid().v1(),
      coin: coin,
      coinPrice: coinPrice,
      amount: amount,
      type: type,
      createdAt: DateTime.now(),
    );
  }

  static List<Trade> filterTrades(
    List<Trade> trades,
    FilterTradesState filter,
  ) {
    return trades.where((trade) {
      if (filter.coinName.isNotEmpty &&
          !trade.coin.name.toLowerCase().contains(
            filter.coinName.toLowerCase(),
          )) {
        return false;
      } else if (filter.tradeType != TradeType.all &&
          trade.type != filter.tradeType) {
        return false;
      }

      if (filter.dateRange != null) {
        final start = filter.dateRange!.start;
        final end = filter.dateRange!.end;
        if (trade.createdAt.isBefore(start) || trade.createdAt.isAfter(end)) {
          return false;
        }
      }

      if (filter.totalPriceRange != null) {
        final range = filter.totalPriceRange!;
        if (trade.totalPrice < range.start || trade.totalPrice > range.end) {
          return false;
        }
      }

      if (filter.amountRange != null) {
        final range = filter.amountRange!;
        if (trade.amount < range.start || trade.amount > range.end) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  static List<Trade> sortTrades(List<Trade> trades, TradeSortType sort) {
    final sorted = List<Trade>.from(trades);
    sorted.sort(switch (sort) {
      TradeSortType.newestFirst => (a, b) => b.createdAt.compareTo(a.createdAt),
      TradeSortType.oldestFirst => (a, b) => a.createdAt.compareTo(b.createdAt),
      TradeSortType.highestTotal => (a, b) => b.totalPrice.compareTo(
        a.totalPrice,
      ),
      TradeSortType.lowestTotal => (a, b) => a.totalPrice.compareTo(
        b.totalPrice,
      ),
      TradeSortType.highestAmount => (a, b) => b.amount.compareTo(a.amount),
      TradeSortType.lowestAmount => (a, b) => a.amount.compareTo(b.amount),
    });

    return sorted;
  }
}

enum TradeType {
  all('Все'),
  buy('Покупка'),
  sell('Продажа');

  final String type;

  const TradeType(this.type);
}

extension DataPrices on List<Trade> {
  double get tradesTotalPrice =>
      map((t) => t.totalPrice).toList().fold(0.0, (sum, p) => sum + p);

  int get boughtCoinsLength =>
      map((t) => t.amount).toList().fold(0, (sum, p) => sum + p);
}
