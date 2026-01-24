import 'package:crypto_simulator/data/models/crypto_coin.dart';
import 'package:crypto_simulator/data/models/trade.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_user.g.dart';

@JsonSerializable(explicitToJson: true)
class AppUser {
  final String id;
  final String name;
  final DateTime createdAt;
  final double balance;
  final List<({CryptoCoin info, int amount})> coins;
  final List<Trade> trades;

  const AppUser({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.balance,
    this.coins = const [],
    this.trades = const [],
  });

  List<String> get coinsSymbols => coins.map((c) => c.info.symbol).toList();

  int get allCoinsLength =>
      coins.map((c) => c.amount).toList().fold(0, (sum, c) => sum + c);

  double get tradesTotalPrice =>
      trades.map((t) => t.totalPrice).toList().fold(0.0, (sum, p) => sum + p);

  int get boughtCoinsLength =>
      trades.map((t) => t.amount).toList().fold(0, (sum, p) => sum + p);

  double coinsBalance(List<({double price, String symbol})> prices) {
    return coins.fold(0.0, (sum, coin) {
      final price = prices.firstWhere(
            (p) => p.symbol == coin.info.symbol,
        orElse: () => (price: 0, symbol: ''),
      );
      return sum + (price.price * coin.amount);
    });
  }

  AppUser copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
    double? balance,
    List<({CryptoCoin info, int amount})>? coins,
    List<Trade>? trades,
  }) {
    return AppUser(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      balance: balance ?? this.balance,
      coins: coins ?? this.coins,
      trades: trades ?? this.trades,
    );
  }

  Map<String, dynamic> toJson() => _$AppUserToJson(this);

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  factory AppUser.create(String id, String name) {
    return AppUser(
      id: id,
      name: name,
      createdAt: DateTime.now(),
      balance: 1000,
    );
  }

  factory AppUser.buyCoins(AppUser user, Trade trade) {
    final coins = List.of(user.coins);
    final index = coins.indexWhere((e) => e.info.symbol == trade.coin.symbol);
    if (index != -1) {
      coins[index] = (
      info: coins[index].info,
      amount: coins[index].amount + trade.amount,
      );
    } else {
      coins.add((info: trade.coin, amount: trade.amount));
    }
    return user.copyWith(
      balance: user.balance - trade.totalPrice,
      coins: coins,
      trades: [trade, ...user.trades],
    );
  }

  factory AppUser.sellCoins(AppUser user, Trade trade) {
    final coins = List.of(user.coins);
    final index = coins.indexWhere((e) => e.info.symbol == trade.coin.symbol);
    if (trade.amount == coins[index].amount) {
      coins.removeAt(index);
    } else {
      coins[index] = (
      info: coins[index].info,
      amount: coins[index].amount - trade.amount,
      );
    }
    return user.copyWith(
      balance: user.balance + trade.totalPrice,
      coins: coins,
      trades: [trade, ...user.trades],
    );
  }

  ({CryptoCoin info, int amount}) findCoin(CryptoCoin coin) {
    final userCoin = coins.firstWhere(
          (c) => c.info.symbol == coin.symbol,
      orElse: () => (amount: 0, info: coin),
    );
    return userCoin;
  }
}
