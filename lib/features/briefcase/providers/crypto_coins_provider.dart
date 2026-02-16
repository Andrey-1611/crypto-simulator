import 'package:Bitmark/data/models/app_user_details.dart';
import 'package:Bitmark/data/models/coin_amount.dart';
import 'package:Bitmark/features/briefcase/providers/briefcase_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories/crypto_repository.dart';

final cryptoCoinsProvider =
    FutureProvider.family<
      List<({CoinAmount coin, double price})>,
      AppUserDetails?
    >((ref, user) async {
      final data = await ref.watch(briefcaseNotifierProvider(user).future);
      user = data.user;
      final coinsSymbols = user.coins.map((coin) => coin.coin.symbol).toList();
      if (coinsSymbols.isEmpty) return [];
      final coinsPrices = await ref
          .read(cryptoRepositoryProvider)
          .getCoinsPricesBySymbols(coinsSymbols);
      final details = coinsPrices.map((detail) {
        final coin = user!.coins.firstWhere(
          (c) => c.coin.symbol == detail.symbol,
        );
        return (coin: coin, price: detail.price);
      }).toList();
      return details;
    });
