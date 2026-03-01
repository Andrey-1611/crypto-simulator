import 'package:Bitmark/data/data_sources/crypto_data_source.dart';
import 'package:Bitmark/data/models/coin_price.dart';
import 'package:Bitmark/data/models/crypto_coin_details.dart';
import 'package:Bitmark/data/models/price_point.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import '../mock_data.dart';

class MockDio extends Mock implements Dio {
  @override
  BaseOptions options = BaseOptions();
}

void main() {
  late CryptoDataSource dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    mockDio.options = BaseOptions();
    dataSource = CryptoDataSource(mockDio);
  });

  group('CryptoDataSource', () {
    test('getCoinDetailsBySymbol(CryptoCoin coin)', () async {
      when(() => mockDio.get(any())).thenAnswer(
        (_) async => Response(
          data: MockData.coinBTCDetailsMap,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      final result = await dataSource.getCoinDetailsBySymbol(MockData.coinBTC);
      expect(result, isA<CryptoCoinDetails>());
      expect(result.info.symbol, MockData.coinBTC.symbol);
    });

    test('updateCoinsPrices(List<CryptoCoin> coins)', () async {
      when(() => mockDio.get(any())).thenAnswer(
        (_) async => Response(
          data: MockData.coinsPricesMaps,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      final result = await dataSource.updateCoinsPrices(MockData.coins);
      expect(result, isA<List<CoinPrice>>());
      expect(result.length, MockData.coins.length);
    });

    test('getCoinPriceBySymbol(String symbol)', () async {
      when(() => mockDio.get(any())).thenAnswer(
        (_) async => Response(
          data: MockData.coinPriceMap,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      final result = await dataSource.getCoinPriceBySymbol(
        MockData.coinBTC.symbol,
      );
      expect(result, isA<double>());
    });
  });

  test('getCoinsPricesBySymbols(List<String> symbols)', () async {
    when(() => mockDio.get(any())).thenAnswer(
      (_) async => Response(
        data: MockData.coinsPricesMaps,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );
    final result = await dataSource.getCoinsPricesBySymbols([
      MockData.coinBTC.symbol,
      MockData.coinETH.symbol,
    ]);
    expect(result, isA<List<({double price, String symbol})>>());
  });

  test('getCoinsByMarketCap(int page)', () async {
    when(() => mockDio.get(any())).thenAnswer(
      (_) async => Response(
        data: MockData.coinsTopListMap,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );
    final result = await dataSource.getCoinsByMarketCap(1);
    expect(result, isA<List<CoinPrice>>());
  });

  test('getCoinsByMarketCap(int page)', () async {
    when(() => mockDio.get(any())).thenAnswer(
      (_) async => Response(
        data: MockData.coinsTopListMap,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );
    final result = await dataSource.getCoinsByMarketCap(0);
    expect(result, isA<List<CoinPrice>>());
  });

  test('getCoinsByVolume(int page)', () async {
    when(() => mockDio.get(any())).thenAnswer(
      (_) async => Response(
        data: MockData.coinsTopListMap,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );
    final result = await dataSource.getCoinsByVolume(0);
    expect(result, isA<List<CoinPrice>>());
  });

  test('getCoinsByPercentChange(int page)', () async {
    when(
      () => mockDio.get(
        any(that: predicate<String>((url) => url.contains('top'))),
      ),
    ).thenAnswer(
      (_) async => Response(
        data: MockData.coinsTopListEndopointMap,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );
    when(
      () => mockDio.get(
        any(that: predicate<String>((url) => url.contains('price'))),
      ),
    ).thenAnswer(
      (_) async => Response(
        data: MockData.coinsPricesMaps,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );
    final result = await dataSource.getCoinsByPercentChange(0);
    expect(result, isA<List<CoinPrice>>());
  });

  test('getCoinsByPrice(int page)', () async {
    when(
      () => mockDio.get(
        any(that: predicate<String>((url) => url.contains('top/price'))),
      ),
    ).thenAnswer(
      (_) async => Response(
        data: MockData.coinsTopListEndopointMap,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );
    when(
      () => mockDio.get(
        any(that: predicate<String>((url) => url.contains('pricemulti'))),
      ),
    ).thenAnswer(
      (_) async => Response(
        data: MockData.coinsPricesMaps,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );
    final result = await dataSource.getCoinsByPrice(0);
    expect(result, isA<List<CoinPrice>>());
  });

  test('searchCoins(String query)', () async {
    when(() => mockDio.get(any())).thenAnswer(
      (_) async => Response(
        data: MockData.searchCoinsMap,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );
    when(
      () => mockDio.get(
        any(that: predicate<String>((url) => url.contains('pricemulti'))),
      ),
    ).thenAnswer(
      (_) async => Response(
        data: MockData.coinsPricesMaps,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );
    final result = await dataSource.searchCoins('');
    expect(result, isA<List<CoinPrice>>());
  });

  test('getCoinPriceHistoryBySymbol(String symbol)', () async {
    when(() => mockDio.get(any())).thenAnswer(
      (_) async => Response(
        data: MockData.coinsHistoryPriceMap,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );
    final result = await dataSource.getCoinPriceHistoryBySymbol(
      MockData.coinBTC.symbol,
    );
    expect(result, isA<List<PricePoint>>());
  });
}
