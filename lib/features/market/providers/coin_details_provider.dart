import 'package:Bitmark/data/models/coin_full_data.dart';
import 'package:Bitmark/data/models/price_point.dart';
import 'package:Bitmark/features/market/providers/compare_coins_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../data/models/crypto_coin.dart';
import '../../../data/repositories/crypto_repository.dart';

final coinDetailsNotifierProvider = AsyncNotifierProvider.autoDispose
    .family<CoinDetailsNotifier, CoinFullData, CryptoCoin>(
      (coin) => CoinDetailsNotifier(coin: coin),
    );

final _dailyHistory = StateProvider<List<PricePoint>>((_) => []);
final _hourlyHistory = StateProvider<List<PricePoint>>((_) => []);

final coinDetailsPeriodProvider = StateProvider<CoinDetailsPeriod>(
  (_) => .year,
);

class CoinDetailsNotifier extends AsyncNotifier<CoinFullData> {
  final CryptoCoin coin;

  CoinDetailsNotifier({required this.coin});

  @override
  Future<CoinFullData> build() async {
    CoinFullData coinData = await ref
        .read(cryptoRepositoryProvider)
        .getCoinFullDataById(coin);
    ref.read(compareCoinsNotifierProvider.notifier).setFirstCoin(coinData);
    ref.read(_dailyHistory.notifier).state = coinData.dailyPrices;
    ref.read(_hourlyHistory.notifier).state = coinData.hourlyPrices;
    final period = ref.read(coinDetailsPeriodProvider);
    if (period != .year) {
      if (period.days >= 90) {
        return coinData.copyWith(
          dailyPrices: coinData.dailyPrices.sublist(
            coinData.dailyPrices.length - period.days,
          ),
        );
      } else {
        return coinData.copyWith(
          hourlyPrices: coinData.hourlyPrices.sublist(
            coinData.hourlyPrices.length - period.days * 24,
          ),
        );
      }
    }
    return coinData;
  }

  void changePeriod(CoinDetailsPeriod period) {
    final dailyPrices = ref.read(_dailyHistory);
    final hourlyPrices = ref.read(_hourlyHistory);
    late final CoinFullData newCoin;
    if (period.days >= 90) {
      final newPrices = dailyPrices.sublist(dailyPrices.length - period.days);
      newCoin = state.requireValue.copyWith(dailyPrices: newPrices);
    } else {
      final newPrices = hourlyPrices.sublist(
        hourlyPrices.length - period.days * 24,
      );
      newCoin = state.requireValue.copyWith(hourlyPrices: newPrices);
    }
    state = .data(newCoin);
    ref.read(coinDetailsPeriodProvider.notifier).state = period;
  }
}

enum CoinDetailsPeriod {
  week(7),
  month(30),
  threeMonths(90),
  sixMonths(180),
  year(365);

  final int days;

  const CoinDetailsPeriod(this.days);
}
