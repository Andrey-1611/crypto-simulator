import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_simulator/data/models/trade.dart';

class AppUser {
  final String id;
  final String name;
  final DateTime createdAt;
  final double balance;
  final List<({String symbol, int amount})> coins;
  final List<Trade> trades;

  const AppUser({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.balance,
    required this.coins,
    required this.trades,
  });

  @override
  String toString() {
    return 'AppUser{'
        ' id: $id,'
        ' name: $name,'
        ' createdAt: $createdAt,'
        ' balance: $balance,'
        ' coins: $coins,'
        ' trades: $trades,'
        '}';
  }

  AppUser copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
    double? balance,
    List<({String symbol, int amount})>? coins,
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt,
      'balance': balance,
      'coins': coins,
      'trades': trades,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'] as String,
      name: map['name'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      balance: map['balance'] as double,
      coins: List<({String symbol, int amount})>.from(map['coins'] as List),
      trades: List.from(map['trades'] as List),
    );
  }

  factory AppUser.create(String id, String name) {
    return AppUser(
      id: id,
      name: name,
      createdAt: DateTime.now(),
      balance: 1000,
      coins: [],
      trades: [],
    );
  }

  factory AppUser.addTrade(AppUser user, Trade trade) {
    final coins = List.of(user.coins);
    final index = coins.indexWhere((coin) => coin.symbol == trade.coinSymbol);
    if (index != -1) {
      coins[index] = (
        symbol: coins[index].symbol,
        amount: coins[index].amount + trade.amount,
      );
    } else {
      coins.add((symbol: trade.coinSymbol, amount: trade.amount));
    }
    final balance = trade.type == TradeType.buy
        ? user.balance - trade.totalPrice
        : user.balance + trade.totalPrice;
    return user.copyWith(
      balance: balance,
      coins: coins,
      trades: [...user.trades, trade],
    );
  }
}
