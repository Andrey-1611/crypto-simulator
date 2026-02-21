import 'package:Bitmark/app/runner/app_dependencies.dart';
import 'package:Bitmark/data/data_sources/crypto_data_source.dart';
import 'package:Bitmark/data/models/coin_price.dart';
import 'package:Bitmark/data/models/crypto_coin.dart';
import 'package:Bitmark/data/models/crypto_coin_details.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cryptoRepositoryProvider = Provider<CryptoRepository>((ref) {
  return CryptoDataSource(ref.watch(dioProvider));
});

abstract interface class CryptoRepository {
  Future<CryptoCoinDetails> getCoinDetailsBySymbol(CryptoCoin coin);

  Future<List<CoinPrice>> updateCoinsPrices(List<CryptoCoin> coins);

  Future<double> getCoinPriceBySymbol(String symbol);

  Future<List<({String symbol, double price})>> getCoinsPricesBySymbols(
    List<String> symbols,
  );

  Future<List<CoinPrice>> getCoinsByVolume(int page);

  Future<List<CoinPrice>> getCoinsByMarketCap(int page);

  Future<List<CoinPrice>> getCoinsByPrice(int page);

  Future<List<CoinPrice>> getCoinsByPercentChange(int page);
}
