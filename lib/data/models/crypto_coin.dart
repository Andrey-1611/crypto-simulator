import 'package:Bitmark/core/constants/api_constants.dart';

class CryptoCoin {
  final String id;
  final String symbol;
  final String name;
  final String imageUrl;

  String get fullImageUrl => imageUrl.startsWith('http')
      ? imageUrl
      : '${ApiConstants.imagesHost}/$imageUrl';

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

  factory CryptoCoin.fromApi(Map<String, dynamic> map) {
    return CryptoCoin(
      id: map['Id'] as String,
      symbol: map['Name'] as String,
      name: map['FullName'] as String,
      imageUrl: map['ImageUrl'] as String,
    );
  }

  factory CryptoCoin.fromNewApi(Map<String, dynamic> map) {
    return CryptoCoin(
      id: map['ID'].toString(),
      symbol: map['SYMBOL'] as String,
      name: map['NAME'] as String,
      imageUrl: map['LOGO_URL'] as String? ?? '',
    );
  }

  factory CryptoCoin.empty() =>
      const CryptoCoin(id: '', symbol: '', name: '', imageUrl: '');

  CryptoCoin copyWith({
    String? id,
    String? symbol,
    String? name,
    String? imageUrl,
  }) {
    return CryptoCoin(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
