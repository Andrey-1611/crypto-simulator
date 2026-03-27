import 'package:Bitmark/data/models/crypto_coin_details.dart';
import 'package:Bitmark/data/models/trade.dart';

class CoinTradesUtils {
  final CryptoCoinDetails _coin;
  final List<Trade> _trades;

  CoinTradesUtils({
    required CryptoCoinDetails coin,
    required List<Trade> trades,
  }) : _coin = coin,
       _trades = trades;

  List<Trade> get coinTrades =>
      _trades.where((t) => t.coin.id == _coin.info.id).toList();

  int get tradesCount => coinTrades.length;

  int get totalBought => coinTrades
      .where((t) => t.type == .buy)
      .fold(0, (sum, t) => sum + t.amount);

  int get totalSold => coinTrades
      .where((t) => t.type == .sell)
      .fold(0, (sum, t) => sum + t.amount);

  int get amount => totalBought - totalSold;

  double get totalSpent => coinTrades
      .where((t) => t.type == .buy)
      .fold(0.0, (sum, t) => sum + t.totalPrice);

  double get totalReceived => coinTrades
      .where((t) => t.type == .sell)
      .fold(0.0, (sum, t) => sum + t.totalPrice);

  double get avgBuyPrice {
    final bought = coinTrades.where((t) => t.type == .buy);
    final totalAmount = bought.fold(0, (sum, t) => sum + t.amount);
    if (totalAmount == 0) return 0;

    final totalCost = bought.fold(0.0, (sum, t) => sum + t.totalPrice);
    return totalCost / totalAmount;
  }

  double get pnl {
    final currentValue = amount * _coin.priceData.price;
    return currentValue + totalReceived - totalSpent;
  }

  double get pnlPercent {
    if (totalSpent == 0) return 0;
    return (pnl / totalSpent) * 100;
  }
}
