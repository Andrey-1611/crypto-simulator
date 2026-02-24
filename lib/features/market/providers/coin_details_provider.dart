import 'package:Bitmark/data/models/price_point.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/crypto_coin.dart';
import '../../../data/models/crypto_coin_details.dart';
import '../../../data/repositories/crypto_repository.dart';

final coinDetailsProvider = FutureProvider.autoDispose
    .family<({CryptoCoinDetails coin, List<PricePoint> prices}), CryptoCoin>((
      ref,
      coin,
    ) async {
      final coinDetails = await ref
          .read(cryptoRepositoryProvider)
          .getCoinDetailsBySymbol(coin);
      final prices = await ref
          .read(cryptoRepositoryProvider)
          .getCoinPriceHistoryBySymbol(coin.symbol);
      return (coin: coinDetails, prices: prices);
    });
