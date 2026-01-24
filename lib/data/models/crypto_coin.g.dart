// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_coin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoCoin _$CryptoCoinFromJson(Map<String, dynamic> json) => CryptoCoin(
  id: json['id'] as String,
  symbol: json['symbol'] as String,
  name: json['name'] as String,
  imageUrl: json['imageUrl'] as String,
);

Map<String, dynamic> _$CryptoCoinToJson(CryptoCoin instance) =>
    <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
    };
