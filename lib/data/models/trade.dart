import 'package:crypto_simulator/data/models/crypto_coin.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

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

  String get createdAtFormat =>
      DateFormat('dd.MM.yyyy HH:mm').format(createdAt);

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
}

enum TradeType {
  buy('Покупка'),
  sell('Продажа');

  final String type;

  const TradeType(this.type);
}
