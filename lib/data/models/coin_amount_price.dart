import 'package:Bitmark/data/models/coin_amount.dart';
import 'package:Bitmark/features/briefcase/providers/sort_coins_provider.dart';
import '../../features/briefcase/providers/filter_coins_provider.dart';

class CoinAmountPrice {
  final CoinAmount coinAmount;
  final double price;

  double get totalPrice => price * coinAmount.amount;

  CoinAmountPrice({required this.coinAmount, required this.price});

  static List<CoinAmountPrice> filterCoins(
    List<CoinAmountPrice> coins,
    FilterCoinsState filter,
  ) {
    return coins.where((coin) {
      if (filter.coinName.isNotEmpty) {
        final query = filter.coinName.toLowerCase();

        final matchesName = coin.coinAmount.coin.name.toLowerCase().contains(
          query,
        );

        final matchesSymbol = coin.coinAmount.coin.symbol
            .toLowerCase()
            .contains(query);

        if (!matchesName && !matchesSymbol) {
          return false;
        }
      }

      if (filter.priceRange != null) {
        final range = filter.priceRange!;
        if (coin.price < range.start || coin.price > range.end) {
          return false;
        }
      }

      if (filter.totalPriceRange != null) {
        final range = filter.totalPriceRange!;
        if (coin.totalPrice < range.start || coin.totalPrice > range.end) {
          return false;
        }
      }

      if (filter.amountRange != null) {
        final range = filter.amountRange!;
        if (coin.coinAmount.amount < range.start ||
            coin.coinAmount.amount > range.end) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  static List<CoinAmountPrice> sortCoins(
    List<CoinAmountPrice> coins,
    CoinSortType sort,
  ) {
    coins.sort(
      (a, b) => switch (sort) {
        CoinSortType.moreCoins => b.coinAmount.amount.compareTo(
          a.coinAmount.amount,
        ),
        CoinSortType.lessCoins => a.coinAmount.amount.compareTo(
          b.coinAmount.amount,
        ),
        CoinSortType.highPrice => b.price.compareTo(a.price),
        CoinSortType.lowPrice => a.price.compareTo(b.price),
        CoinSortType.highTotal => b.totalPrice.compareTo(a.totalPrice),
        CoinSortType.lowTotal => a.totalPrice.compareTo(b.totalPrice),
      },
    );
    return coins;
  }
}
