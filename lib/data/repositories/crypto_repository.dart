import 'package:crypto_simulator/app/runner/app_dependencies.dart';
import 'package:crypto_simulator/data/data_sources/crypto_data_source.dart';
import 'package:crypto_simulator/data/models/crypto_coin.dart';
import 'package:crypto_simulator/data/models/crypto_coin_details.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cryptoRepositoryProvider = Provider<CryptoRepository>((ref) {
  return CryptoDataSource(ref.watch(dioProvider));
});

abstract interface class CryptoRepository {
  Future<List<CryptoCoinDetails>> getCoins(int page);

  Future<CryptoCoinDetails> getCoinBySimbol(CryptoCoin coin);

  Future<List<CryptoCoinDetails>> getCoinsBySymbols(List<CryptoCoin> coins);

  Future<double> getCoinPriceBySimbol(String symbol);

  Future<List<({String symbol, double price})>> getCoinsPricesBySymbols(
    List<String> symbols,
  );
}
