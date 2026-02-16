import 'package:Bitmark/data/models/trade.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'app_user.dart';
import 'coin_amount.dart';
import 'crypto_coin.dart';

class AppUserDetails {
  final String id;
  final String name;
  final String email;
  final DateTime createdAt;
  final double balance;
  final List<CoinAmount> coins;

  const AppUserDetails({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.balance,
    required this.coins,
  });

  List<String> get coinsSymbols => coins.map((c) => c.coin.symbol).toList();

  int get allCoinsLength =>
      coins.map((c) => c.amount).toList().fold(0, (balance, c) => balance + c);

  double coinsBalance(List<({double price, String symbol})> prices) {
    return coins.fold(0.0, (balance, coin) {
      final price = prices.firstWhere(
        (p) => p.symbol == coin.coin.symbol,
        orElse: () => (price: 0, symbol: ''),
      );
      return balance + (price.price * coin.amount);
    });
  }

  factory AppUserDetails.create(AppUser user) {
    return AppUserDetails(
      id: user.id,
      name: user.name,
      email: user.email,
      createdAt: user.createdAt,
      balance: 1000,
      coins: [],
    );
  }

  factory AppUserDetails.buyCoins(AppUserDetails user, Trade trade) {
    final coins = List.of(user.coins);
    final index = coins.indexWhere((e) => e.coin.symbol == trade.coin.symbol);
    if (index != -1) {
      coins[index] = coins[index].copyWith(
        amount: coins[index].amount + trade.amount,
      );
    } else {
      coins.add(CoinAmount(coin: trade.coin, amount: trade.amount));
    }
    return user.copyWith(
      balance: user.balance - trade.totalPrice,
      coins: coins,
    );
  }

  factory AppUserDetails.sellCoins(AppUserDetails user, Trade trade) {
    final coins = List.of(user.coins);
    final index = coins.indexWhere((e) => e.coin.symbol == trade.coin.symbol);
    if (trade.amount == coins[index].amount) {
      coins.removeAt(index);
    } else {
      coins[index] = coins[index].copyWith(
        amount: coins[index].amount - trade.amount,
      );
    }
    return user.copyWith(
      balance: user.balance + trade.totalPrice,
      coins: coins,
    );
  }

  CoinAmount findCoin(CryptoCoin coin) {
    final userCoin = coins.firstWhere(
      (c) => c.coin.symbol == coin.symbol,
      orElse: () => CoinAmount.empty(),
    );
    return userCoin;
  }

  AppUserDetails copyWith({
    String? id,
    String? name,
    String? email,
    DateTime? createdAt,
    double? balance,
    List<CoinAmount>? coins,
  }) {
    return AppUserDetails(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      balance: balance ?? this.balance,
      coins: coins ?? this.coins,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'createdAt': Timestamp.fromDate(createdAt),
      'balance': balance,
      'coins': coins.map((c) => c.toJson()).toList(),
    };
  }

  factory AppUserDetails.fromJson(Map<String, dynamic> map) {
    return AppUserDetails(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      balance: map['balance'] as double,
      coins: (map['coins'] as List)
          .map((e) => CoinAmount.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
