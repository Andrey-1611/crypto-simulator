import 'package:Bitmark/data/models/coin_full_data.dart';
import 'package:Bitmark/data/models/price_point.dart';
import 'package:Bitmark/features/market/providers/compare_coins_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../data/models/crypto_coin.dart';
import '../../../data/repositories/crypto_repository.dart';

final coinDetailsNotifierProvider =
    AsyncNotifierProvider.family<CoinDetailsNotifier, CoinFullData, CryptoCoin>(
      (coin) => CoinDetailsNotifier(coin: coin),
    );

final _coinAllHistory = StateProvider<List<PricePoint>>((_) => []);

final coinDetailsPeriodProvider = StateProvider<CoinDetailsPeriod>((_) => .year);

class CoinDetailsNotifier extends AsyncNotifier<CoinFullData> {
  final CryptoCoin coin;

  CoinDetailsNotifier({required this.coin});

  @override
  Future<CoinFullData> build() async {
    final details = await ref
        .read(cryptoRepositoryProvider)
        .getCoinDetailsBySymbol(coin);
    final prices = await ref
        .read(cryptoRepositoryProvider)
        .getCoinPriceHistoryBySymbol(coin.symbol);
    final coinData = CoinFullData(coin: details, prices: prices);
    ref.read(compareCoinsNotifierProvider.notifier).setFirstCoin(coinData);
    ref.read(_coinAllHistory.notifier).state = prices;
    return coinData;
  }

  void changePeriod(CoinDetailsPeriod period) {
    final allPrices = ref.read(_coinAllHistory);
    final newPrices = allPrices.sublist(allPrices.length - period.days);
    state = .data(state.requireValue.copyWith(prices: newPrices));
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

