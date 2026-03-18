import 'dart:async';
import 'package:Bitmark/data/models/coin_full_data.dart';
import 'package:Bitmark/data/models/crypto_coin.dart';
import 'package:Bitmark/data/repositories/crypto_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final compareCoinsNotifierProvider =
    AsyncNotifierProvider<CompareCoinsNotifier, List<CoinFullData>>(
      CompareCoinsNotifier.new,
    );

final compareCoinsPeriodProvider = StateProvider<CompareCoinsPeriod>(
  (_) => .year,
);

final lineChartTypeProvider = StateProvider<LineChartType>((_) => .price);

final _coinsAllHistoryProvider = StateProvider<List<CoinFullData>>((_) => []);

class CompareCoinsNotifier extends AsyncNotifier<List<CoinFullData>> {
  @override
  FutureOr<List<CoinFullData>> build() => <CoinFullData>[];

  void setFirstCoin(CoinFullData coinData) {
    state = .data([coinData]);
    ref.read(_coinsAllHistoryProvider.notifier).state = [coinData];
  }

  void addCoin(CryptoCoin coin) async {
    final coins = state.requireValue;
    state = const .loading();
    state = await .guard(() async {
      if (coins.map((c) => c.coin.info.symbol).contains(coin.symbol)) {
        return coins;
      }
      CoinFullData coinData = await ref
          .read(cryptoRepositoryProvider)
          .getCoinFullDataById(coin);
      final allCoins = ref.read(_coinsAllHistoryProvider.notifier);
      allCoins.state = [...allCoins.state, coinData];
      final period = ref.read(compareCoinsPeriodProvider);
      if (period.days >= 90) {
        final start = (coinData.dailyPrices.length - period.days).clamp(
          0,
          coinData.dailyPrices.length,
        );
        coinData = coinData.copyWith(
          dailyPrices: coinData.dailyPrices.sublist(start),
        );
      } else {
        final start = (coinData.hourlyPrices.length - period.days * 24).clamp(
          0,
          coinData.hourlyPrices.length,
        );
        coinData = coinData.copyWith(
          hourlyPrices: coinData.hourlyPrices.sublist(start),
        );
      }
      return [...coins, coinData];
    });
  }

  void removeCoin(String coinSymbol) {
    final updated = state.requireValue
        .where((c) => c.coin.info.symbol != coinSymbol)
        .toList();
    ref.read(_coinsAllHistoryProvider.notifier).state = updated;
    state = .data(updated);
  }

  void removeAll() {
    state = const .data([]);
    ref.read(_coinsAllHistoryProvider.notifier).state = [];
  }

  void changePeriod(CompareCoinsPeriod period) {
    final allCoins = ref.read(_coinsAllHistoryProvider);
    final updated = allCoins.map((c) {
      if (period.days >= 90) {
        final start = (c.dailyPrices.length - period.days).clamp(
          0,
          c.dailyPrices.length,
        );
        return c.copyWith(dailyPrices: c.dailyPrices.sublist(start));
      } else {
        final start = (c.hourlyPrices.length - period.days * 24).clamp(
          0,
          c.hourlyPrices.length,
        );
        return c.copyWith(hourlyPrices: c.hourlyPrices.sublist(start));
      }
    }).toList();
    state = .data(updated);
    ref.read(compareCoinsPeriodProvider.notifier).state = period;
  }
}

enum CompareCoinsPeriod {
  week(7),
  month(30),
  threeMonths(90),
  sixMonths(180),
  year(365);

  final int days;

  const CompareCoinsPeriod(this.days);
}

enum LineChartType { price, percentChange }
