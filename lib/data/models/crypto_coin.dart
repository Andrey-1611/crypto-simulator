import 'package:Bitmark/core/constants/api_constants.dart';
import 'package:Bitmark/data/models/crypto_coin_details.dart';
import 'package:json_annotation/json_annotation.dart';

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

  Map<String, dynamic> toJson() {
    return {'id': id, 'symbol': symbol, 'name': name, 'imageUrl': imageUrl};
  }

  factory CryptoCoin.fromJson(Map<String, dynamic> map) {
    return CryptoCoin(
      id: map['id'] as String,
      symbol: map['symbol'] as String,
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  factory CryptoCoin.fromDetails(CryptoCoinDetails details) {
    return CryptoCoin(
      id: details.id,
      symbol: details.symbol,
      name: details.name,
      imageUrl: details.imageUrl,
    );
  }

  factory CryptoCoin.empty() =>
      const CryptoCoin(id: '', symbol: '', name: '', imageUrl: '');
}
