// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_coin_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoCoinDetails _$CryptoCoinDetailsFromJson(Map<String, dynamic> json) =>
    CryptoCoinDetails(
      id: json['id'] as String,
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      currentPrice: (json['currentPrice'] as num).toDouble(),
      changePercent24h: (json['changePercent24h'] as num).toDouble(),
      priceChange24h: (json['priceChange24h'] as num).toDouble(),
      high24h: (json['high24h'] as num).toDouble(),
      low24h: (json['low24h'] as num).toDouble(),
      marketCap: (json['marketCap'] as num).toDouble(),
      volume24h: (json['volume24h'] as num).toDouble(),
      circulatingSupply: (json['circulatingSupply'] as num).toDouble(),
    );

Map<String, dynamic> _$CryptoCoinDetailsToJson(CryptoCoinDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'currentPrice': instance.currentPrice,
      'changePercent24h': instance.changePercent24h,
      'priceChange24h': instance.priceChange24h,
      'high24h': instance.high24h,
      'low24h': instance.low24h,
      'marketCap': instance.marketCap,
      'volume24h': instance.volume24h,
      'circulatingSupply': instance.circulatingSupply,
    };
