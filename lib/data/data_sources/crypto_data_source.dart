import 'package:crypto_simulator/core/constants/api_constants.dart';
import 'package:crypto_simulator/data/models/crypto_coin.dart';
import 'package:crypto_simulator/data/repositories/crypto_repository.dart';
import 'package:dio/dio.dart';

class CryptoDataSource implements CryptoRepository {
  final Dio _dio;

  CryptoDataSource(this._dio);

  @override
  Future<List<CryptoCoin>> getCryptoCoins(int page) async {
    final response = await _dio.get(ApiConstants.allCoinsUrl(page));
    final data = response.data['Data'] as List;
    return data
        .where((item) {
          final raw = item['RAW'];
          return raw is Map && raw['USD'] is Map;
        })
        .map((e) => CryptoCoin.fromListAPI(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<CryptoCoin> updateCoinPrice(CryptoCoin coin) async {
    final response = await _dio.get(ApiConstants.coinUrl(coin.symbol));
    final data =
        response.data['RAW'][coin.symbol]['USD'] as Map<String, dynamic>;
    return CryptoCoin.fromCoinAPI(data, coin);
  }

  @override
  Future<List<CryptoCoin>> updateCoinsPrice(List<CryptoCoin> coins) async {
    final symbols = coins.map((c) => c.symbol).join(',');
    final response = await _dio.get(ApiConstants.coinUrl(symbols));
    final data = response.data['RAW'];
    return coins.map((coin) {
      final map = data[coin.symbol]['USD'] as Map<String, dynamic>;
      return CryptoCoin.fromCoinAPI(map, coin);
    }).toList();
  }
}
