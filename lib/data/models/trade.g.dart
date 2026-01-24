// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trade _$TradeFromJson(Map<String, dynamic> json) => Trade(
  id: json['id'] as String,
  coinPrice: (json['coinPrice'] as num).toDouble(),
  amount: (json['amount'] as num).toInt(),
  type: $enumDecode(_$TradeTypeEnumMap, json['type']),
  createdAt: DateTime.parse(json['createdAt'] as String),
  coin: CryptoCoin.fromJson(json['coin'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TradeToJson(Trade instance) => <String, dynamic>{
  'id': instance.id,
  'coin': instance.coin.toJson(),
  'coinPrice': instance.coinPrice,
  'amount': instance.amount,
  'type': _$TradeTypeEnumMap[instance.type]!,
  'createdAt': instance.createdAt.toIso8601String(),
};

const _$TradeTypeEnumMap = {TradeType.buy: 'buy', TradeType.sell: 'sell'};
