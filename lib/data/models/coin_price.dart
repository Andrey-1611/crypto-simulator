import 'crypto_coin.dart';

class CoinPrice {
  final CryptoCoin coin;
  final double price;

  CoinPrice({required this.coin, required this.price});

  CoinPrice copyWith({CryptoCoin? coin, double? price}) {
    return CoinPrice(coin: coin ?? this.coin, price: price ?? this.price);
  }

  factory CoinPrice.formAPI(Map<String, dynamic> map) {
    return CoinPrice(
      coin: CryptoCoin.fromApi(
        map['CoinInfo'] as Map<String, dynamic>,
      ),
      price: (map['RAW']['USD']['PRICE'] as num).toDouble(),
    );
  }
}
