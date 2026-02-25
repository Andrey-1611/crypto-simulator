import 'dart:async';
import 'package:Bitmark/data/models/coin_price.dart';
import 'package:Bitmark/data/repositories/crypto_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/runner/app_dependencies.dart';
import '../../../data/models/crypto_coin_details.dart';

final marketNotifierProvider =
    AsyncNotifierProvider<MarketNotifier, List<CoinPrice>>(MarketNotifier.new);

class MarketNotifier extends AsyncNotifier<List<CoinPrice>> {
  int _page = 0;
  bool _loading = false;
  bool _hasMore = true;

  @override
  FutureOr<List<CoinPrice>> build() async {
    ref.keepAlive();
    await ref.read(packageProvider.future);
    return await ref.read(cryptoRepositoryProvider).getCoinsByMarketCap(0);
  }

  Future<void> getCryptoCoins() async {
    if (_loading || !_hasMore) return;
    _loading = true;
    state = await AsyncValue.guard(() async {
      final next = await ref
          .read(cryptoRepositoryProvider)
          .getCoinsByMarketCap(++_page);
      _hasMore = next.isNotEmpty;
      return [...?state.value, ...next];
    });
    _loading = false;
  }

  Future<void> changeSort(SortType sort) async {
    if (_loading || !_hasMore) return;
    _loading = true;
    state = await AsyncValue.guard(() async {
      final repo = ref.read(cryptoRepositoryProvider);
      return switch (sort) {
        .marketCap => await repo.getCoinsByMarketCap(0),
        .volume24h => await repo.getCoinsByVolume(0),
        .change24h => await repo.getCoinsByPercentChange(0),
        .price => await repo.getCoinsByPrice(0),
      };
    });
    _loading = false;
  }

  Future<void> updateCoinsPrices() async {
    final previous = state.value ?? [];
    state = await AsyncValue.guard(() async {
      final coins = previous.map((c) => c.coin).toList();
      return await ref.read(cryptoRepositoryProvider).updateCoinsPrices(coins);
    });
  }
}
