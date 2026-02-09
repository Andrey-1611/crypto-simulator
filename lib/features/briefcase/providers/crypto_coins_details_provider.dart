import 'package:Bitmark/data/models/app_user_details.dart';
import 'package:Bitmark/features/briefcase/providers/briefcase_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/crypto_coin_details.dart';
import '../../../data/repositories/crypto_repository.dart';

final cryptoCoinsDetailsProvider =
    FutureProvider.family<
      List<({CryptoCoinDetails details, int amount})>,
      AppUserDetails?
    >((ref, user) async {
      user = await ref.read(briefcaseNotifierProvider(user).future);
      final coins = user!.coins.map((coin) => coin.coin).toList();
      if (coins.isEmpty) return [];
      final coinsDetails = await ref
          .read(cryptoRepositoryProvider)
          .getCoinsBySymbols(coins);
      final data = coinsDetails.map((detail) {
        final coin = user!.coins.firstWhere(
          (c) => c.coin.symbol == detail.symbol,
        );
        return (details: detail, amount: coin.amount);
      }).toList();
      return data;
    });
