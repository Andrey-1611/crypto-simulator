import 'package:crypto_simulator/core/constants/api_constants.dart';
import 'package:crypto_simulator/data/models/crypto_coin.dart';
import 'package:crypto_simulator/data/models/crypto_coin_details.dart';
import 'package:crypto_simulator/data/repositories/crypto_repository.dart';
import 'package:dio/dio.dart';

class CryptoDataSource implements CryptoRepository {
  final Dio _dio;

  CryptoDataSource(this._dio) {
    _dio.options.baseUrl = ApiConstants.baseUrl;
  }

  @override
  Future<CryptoCoinDetails> getCoinBySimbol(CryptoCoin coin) async {
    final response = await _dio.get(ApiConstants.coinsUrlBySimbol(coin.symbol));
    final data =
        response.data['RAW'][coin.symbol]['USD'] as Map<String, dynamic>;
    final coinDetails = CryptoCoinDetails.fromCoinAPI(data, coin);
    return coinDetails;
  }

  @override
  Future<List<CryptoCoinDetails>> getCoins(int page) async {
    final response = await _dio.get(ApiConstants.coinsUrlByPage(page));
    final data = response.data['Data'] as List;
    return data
        .where((item) {
          final raw = item['RAW'];
          return raw is Map && raw['USD'] is Map;
        })
        .map((e) => CryptoCoinDetails.fromListAPI(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<CryptoCoinDetails>> getCoinsBySymbols(
    List<CryptoCoin> coins,
  ) async {
    final symbols = coins.map((coin) => coin.symbol).toList().join(',');
    if (symbols.isEmpty) return [];
    final response = await _dio.get(ApiConstants.coinsUrlBySimbol(symbols));
    final data = response.data['RAW'] as Map<String, dynamic>;
    final coinsDetails = coins.map((coin) {
      final map = data[coin.symbol]['USD'] as Map<String, dynamic>;
      return CryptoCoinDetails.fromCoinAPI(map, coin);
    }).toList();
    return coinsDetails;
  }

  @override
  Future<double> getCoinPriceBySimbol(String symbol) async {
    final response = await _dio.get(ApiConstants.coinPriceUrlBySimbol(symbol));
    return response.data['USD'];
  }

  @override
  Future<List<({String symbol, double price})>> getCoinsPricesBySymbols(
    List<String> symbols,
  ) async {
    final allSymbols = symbols.join(',');
    final response = await _dio.get(
      ApiConstants.coinPricesUrlBySimbol(allSymbols),
    );
    final data = response.data as Map<String, dynamic>;
    final prices = symbols
        .map((symbol) => (symbol: symbol, price: data[symbol]['USD'] as double))
        .toList();
    return prices;
  }
}
