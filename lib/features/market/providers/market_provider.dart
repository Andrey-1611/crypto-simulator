import 'dart:async';
import 'package:crypto_simulator/data/models/crypto_coin.dart';
import 'package:crypto_simulator/data/repositories/remote_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final sortCoinsProvider = StateProvider<SortType>((ref) => SortType.marketCap);

enum SortType { marketCap, price, change24h, volume }

final marketNotifierProvider =
    AsyncNotifierProvider<MarketNotifier, List<CryptoCoin>>(MarketNotifier.new);

final searchCoinsProvider = StateProvider<String>((ref) => '');

class MarketNotifier extends AsyncNotifier<List<CryptoCoin>> {
  int _page = 0;
  bool _loading = false;
  bool _hasMore = true;

  @override
  FutureOr<List<CryptoCoin>> build() async {
    return await _getCoins(_page);
  }

  Future<void> getCryptoCoins() async {
    if (_loading || !_hasMore) return;
    _loading = true;
    state = await AsyncValue.guard(() async {
      final next = await _getCoins(++_page);
      _hasMore = next.isNotEmpty;
      return [...?state.value, ...next];
    });
    _loading = false;
  }

  Future<void> updateCoinsPrices() async {
    final coins = state.value ?? [];
    state = await AsyncValue.guard(() async {
      return await ref.read(remoteRepositoryProvider).updateCoinsPrice(coins);
    });
  }

  Future<void> updateCoinPrice(CryptoCoin coin) async {
    state = await AsyncValue.guard(() async {
      final newCoin = await ref
          .read(remoteRepositoryProvider)
          .updateCoinPrice(coin);
      return state.value!.map((e) => e.id == newCoin.id ? newCoin : e).toList();
    });
  }

  Future<List<CryptoCoin>> _getCoins(int page) async =>
      await ref.read(remoteRepositoryProvider).getCryptoCoins(page);
}
