import 'dart:async';
import 'package:crypto_simulator/data/repositories/crypto_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/crypto_coin_details.dart';

final marketNotifierProvider =
    AsyncNotifierProvider<MarketNotifier, List<CryptoCoinDetails>>(
      MarketNotifier.new,
    );

class MarketNotifier extends AsyncNotifier<List<CryptoCoinDetails>> {
  int _page = 0;
  bool _loading = false;
  bool _hasMore = true;

  @override
  FutureOr<List<CryptoCoinDetails>> build() async {
    return await ref.read(cryptoRepositoryProvider).getCoins(0);
  }

  Future<void> getCryptoCoins() async {
    if (_loading || !_hasMore) return;
    _loading = true;
    state = await AsyncValue.guard(() async {
      final next = await ref.read(cryptoRepositoryProvider).getCoins(++_page);
      _hasMore = next.isNotEmpty;
      return [...?state.value, ...next];
    });
    _loading = false;
  }

  Future<void> updateCoinsPrices() async {
    final coins = state.value ?? [];
    state = await AsyncValue.guard(() async {
      return await ref.read(cryptoRepositoryProvider).getCoinsBySymbols(coins);
    });
  }
}
