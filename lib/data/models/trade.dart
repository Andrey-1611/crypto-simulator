import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class Trade {
  final String id;
  final String coinSymbol;
  final double coinPrice;
  final int amount;
  final TradeType type;
  final DateTime createdAt;

  double get totalPrice => coinPrice * amount;

  factory Trade.create({
    required String coinSymbol,
    required double coinPrice,
    required int amount,
    required TradeType type,
  }) {
    return Trade(
      id: const Uuid().v1(),
      coinSymbol: coinSymbol,
      coinPrice: coinPrice,
      amount: amount,
      type: type,
      createdAt: DateTime.now(),
    );
  }

  const Trade({
    required this.id,
    required this.coinSymbol,
    required this.coinPrice,
    required this.amount,
    required this.type,
    required this.createdAt,
  });

  @override
  String toString() {
    return 'Trade{'
        ' id: $id,'
        ' coinSymbol: $coinSymbol,'
        ' coinPrice: $coinPrice,'
        ' amount: $amount,'
        ' type: $type,'
        ' createdAt: $createdAt,'
        '}';
  }

  Trade copyWith({
    String? id,
    String? coinSymbol,
    double? coinPrice,
    int? amount,
    TradeType? type,
    DateTime? createdAt,
  }) {
    return Trade(
      id: id ?? this.id,
      coinSymbol: coinSymbol ?? this.coinSymbol,
      coinPrice: coinPrice ?? this.coinPrice,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'coinSymbol': coinSymbol,
      'coinPrice': coinPrice,
      'amount': amount,
      'type': type,
      'createdAt': createdAt,
    };
  }

  factory Trade.fromMap(Map<String, dynamic> map) {
    return Trade(
      id: map['id'] as String,
      coinSymbol: map['coinSymbol'] as String,
      coinPrice: map['coinPrice'] as double,
      amount: map['amount'] as int,
      type: map['type'] as TradeType,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }
}

enum TradeType { buy, sell }
