import 'package:Bitmark/data/models/crypto_coin_details.dart';
import 'package:Bitmark/data/models/price_point.dart';

class CoinFullData {
  final CryptoCoinDetails coin;
  final List<PricePoint> dailyPrices;
  final List<PricePoint> hourlyPrices;

  CoinFullData({
    required this.coin,
    required this.dailyPrices,
    required this.hourlyPrices,
  });

  CoinFullData copyWith({
    CryptoCoinDetails? coin,
    List<PricePoint>? dailyPrices,
    List<PricePoint>? hourlyPrices,
  }) {
    return CoinFullData(
      coin: coin ?? this.coin,
      dailyPrices: dailyPrices ?? this.dailyPrices,
      hourlyPrices: hourlyPrices ?? this.hourlyPrices,
    );
  }
}
