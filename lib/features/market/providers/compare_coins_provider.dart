import 'dart:async';
import 'package:Bitmark/data/models/coin_full_data.dart';
import 'package:Bitmark/data/models/crypto_coin.dart';
import 'package:Bitmark/data/repositories/crypto_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final compareCoinsNotifierProvider =
    AsyncNotifierProvider<CompareCoinsNotifier, List<CoinFullData>>(
      CompareCoinsNotifier.new,
    );

class CompareCoinsNotifier extends AsyncNotifier<List<CoinFullData>> {
  @override
  FutureOr<List<CoinFullData>> build() async => <CoinFullData>[];

  void setFirstCoin(CoinFullData coinData) => state = .data([coinData]);

  void addCoin(CryptoCoin coin) async {
    final coins = state.requireValue;
    state = const .loading();
    state = await .guard(() async {
      if (coins.map((c) => c.coin.info.symbol).toList().contains(coin.symbol)) {
        return coins;
      }
      final coinDetails = await ref
          .read(cryptoRepositoryProvider)
          .getCoinDetailsBySymbol(coin);
      final coinPrices = await ref
          .read(cryptoRepositoryProvider)
          .getCoinPriceHistoryBySymbol(coin.symbol);
      return [...coins, CoinFullData(coin: coinDetails, prices: coinPrices)];
    });
  }

  void removeCoin(String coinSymbol) {}
}
