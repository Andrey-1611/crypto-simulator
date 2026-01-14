import 'package:crypto_simulator/app/runner/app_dependencies.dart';
import 'package:crypto_simulator/data/data_sources/crypto_data_source.dart';
import 'package:crypto_simulator/data/models/crypto_coin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cryptoRepositoryProvider = Provider<CryptoRepository>((ref) {
  return CryptoDataSource(ref.watch(dioProvider));
});

abstract interface class CryptoRepository {
  Future<List<CryptoCoin>> getCryptoCoins(int page);

  Future<CryptoCoin> updateCoinPrice(CryptoCoin coin);

  Future<List<CryptoCoin>> updateCoinsPrice(List<CryptoCoin> coins);
}
