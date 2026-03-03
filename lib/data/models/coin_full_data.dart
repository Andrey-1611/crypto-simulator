import 'package:Bitmark/data/models/crypto_coin_details.dart';
import 'package:Bitmark/data/models/price_point.dart';

class CoinFullData {
  final CryptoCoinDetails coin;
  final List<PricePoint> prices;

  CoinFullData({required this.coin, required this.prices});
}
