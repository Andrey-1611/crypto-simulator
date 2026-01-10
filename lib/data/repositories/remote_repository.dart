import 'package:crypto_simulator/app/runner/app_dependencies.dart';
import 'package:crypto_simulator/data/data_sources/remote_data_source.dart';
import 'package:crypto_simulator/data/models/crypto_coin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final remoteRepositoryProvider = Provider<RemoteRepository>((ref) {
  return RemoteDataSource(ref.watch(dioProvider));
});

abstract interface class RemoteRepository {
  Future<List<CryptoCoin>> getCryptoCoins(int page);
  Future<CryptoCoin> updateCoinPrice(CryptoCoin coin);
  Future<List<CryptoCoin>> updateCoinsPrice(List<CryptoCoin> coins);
}
