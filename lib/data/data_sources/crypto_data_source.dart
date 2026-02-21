import 'package:Bitmark/data/models/coin_price.dart';
import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../models/crypto_coin.dart';
import '../models/crypto_coin_details.dart';
import '../repositories/crypto_repository.dart';

class CryptoDataSource implements CryptoRepository {
  final Dio _dio;

  CryptoDataSource(this._dio) {
    _dio.options.baseUrl = ApiConstants.baseUrl;
  }

  @override
  Future<CryptoCoinDetails> getCoinDetailsBySymbol(CryptoCoin coin) async {
    final response = await _dio.get(ApiConstants.coinsBySimbol(coin.symbol));
    final data =
        response.data['RAW'][coin.symbol]['USD'] as Map<String, dynamic>;
    return CryptoCoinDetails.fromCoinAPI(data, coin);
  }

  @override
  Future<List<CoinPrice>> updateCoinsPrices(List<CryptoCoin> coins) async {
    final symbols = coins.map((coin) => coin.symbol).toList();
    final prices = await getCoinsPricesBySymbols(symbols);
    return coins.map((coin) {
      final price = prices.firstWhere((p) => p.symbol == coin.symbol).price;
      return CoinPrice(coin: coin, price: price);
    }).toList();
  }

  @override
  Future<double> getCoinPriceBySymbol(String symbol) async {
    final response = await _dio.get(ApiConstants.coinPriceBySimbol(symbol));
    return response.data['USD'];
  }

  @override
  Future<List<({String symbol, double price})>> getCoinsPricesBySymbols(
    List<String> symbols,
  ) async {
    final allSymbols = symbols.join(',');
    final response = await _dio.get(
      ApiConstants.coinPricesBySimbol(allSymbols),
    );
    final data = response.data as Map<String, dynamic>;
    return symbols
        .map(
          (symbol) =>
              (symbol: symbol, price: (data[symbol]['USD'] as num).toDouble()),
        )
        .toList();
  }

  @override
  Future<List<CoinPrice>> getCoinsByMarketCap(int page) async {
    final response = await _dio.get(ApiConstants.coinsByMarketCap(page));
    final data = response.data['Data'] as List;
    return data
        .where((item) {
          final raw = item['RAW'];
          return raw is Map && raw['USD'] is Map;
        })
        .map((e) => CoinPrice.formAPI(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<CoinPrice>> getCoinsByVolume(int page) async {
    final response = await _dio.get(ApiConstants.coinsByVolume(page));
    final data = response.data['Data'] as List;
    return data
        .where((item) {
          final raw = item['RAW'];
          return raw is Map && raw['USD'] is Map;
        })
        .map((e) => CoinPrice.formAPI(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<CoinPrice>> getCoinsByPercentChange(int page) async {
    final response = await _dio.get(ApiConstants.coinsByPercentChange(page));
    final data = response.data['Data'] as List;
    final coins = data
        .map((e) => CryptoCoin.fromApi(e['CoinInfo'] as Map<String, dynamic>))
        .toList();
    final symbols = coins.map((c) => c.symbol).toList();
    final prices = await getCoinsPricesBySymbols(symbols);
    return coins.map((coin) {
      final price = prices.firstWhere((p) => p.symbol == coin.symbol).price;
      return CoinPrice(coin: coin, price: price);
    }).toList();
  }

  @override
  Future<List<CoinPrice>> getCoinsByPrice(int page) async {
    final response = await _dio.get(ApiConstants.coinsByPrice(page));
    final data = response.data['Data'] as List;
    final coins = data
        .map((e) => CryptoCoin.fromApi(e['CoinInfo'] as Map<String, dynamic>))
        .toList();
    final symbols = coins.map((c) => c.symbol).toList();
    final prices = await getCoinsPricesBySymbols(symbols);
    return coins.map((coin) {
      final price = prices.firstWhere((p) => p.symbol == coin.symbol).price;
      return CoinPrice(coin: coin, price: price);
    }).toList();
  }
}
