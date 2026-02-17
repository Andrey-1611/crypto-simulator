import 'package:Bitmark/data/models/app_user_details.dart';
import 'package:Bitmark/data/models/coin_amount_price.dart';
import 'package:Bitmark/features/briefcase/providers/briefcase_provider.dart';
import 'package:Bitmark/features/briefcase/providers/filter_coins_provider.dart';
import 'package:Bitmark/features/briefcase/providers/sort_coins_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories/crypto_repository.dart';

final _cryptoCoinsProvider =
    FutureProvider.family<List<CoinAmountPrice>, AppUserDetails?>((
      ref,
      user,
    ) async {
      final data = await ref.watch(briefcaseNotifierProvider(user).future);
      user = data.user;
      final coinsSymbols = user.coins.map((coin) => coin.coin.symbol).toList();
      if (coinsSymbols.isEmpty) return [];
      final coins = await ref
          .read(cryptoRepositoryProvider)
          .getCoinsPricesBySymbols(coinsSymbols);
      final coinsAmounts = coins.map((detail) {
        final coinAmount = user!.coins.firstWhere(
          (c) => c.coin.symbol == detail.symbol,
        );
        return CoinAmountPrice(coinAmount: coinAmount, price: detail.price);
      }).toList();
      return coinsAmounts;
    });

final cryptoCoinsProvider =
    FutureProvider.family<List<CoinAmountPrice>, AppUserDetails?>((
      ref,
      user,
    ) async {
      final coins = await ref.watch(_cryptoCoinsProvider(user).future);
      final filter = ref.watch(filterCoinsProvider);
      final filtered = CoinAmountPrice.filterCoins(coins, filter);
      final sort = ref.watch(sortCoinsProvider);
      return CoinAmountPrice.sortCoins(filtered, sort);
    });
