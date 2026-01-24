import 'package:crypto_simulator/core/constants/api_constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crypto_coin.g.dart';

@JsonSerializable()
class CryptoCoin {
  final String id;
  final String symbol;
  final String name;
  final String imageUrl;

  String get fullImageUrl => '${ApiConstants.imagesHost}/$imageUrl';

  const CryptoCoin({
    required this.id,
    required this.symbol,
    required this.name,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() => _$CryptoCoinToJson(this);

  factory CryptoCoin.fromJson(Map<String, dynamic> json) =>
      _$CryptoCoinFromJson(json);
}
