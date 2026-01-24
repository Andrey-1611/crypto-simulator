import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/crypto_coin_details.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/crypto_repository.dart';
import '../../../data/repositories/remote_repository.dart';

final cryptoCoinsDetailsProvider =
    FutureProvider<List<({CryptoCoinDetails details, int amount})>>((
      ref,
    ) async {
      final userId = await ref.read(authRepositoryProvider).getUserId();
      final user = await ref.read(remoteRepositoryProvider).getUserById(userId);
      final coins = user!.coins.map((coin) => coin.info).toList();
      if (coins.isEmpty) return [];
      final coinsDetails = await ref
          .read(cryptoRepositoryProvider)
          .getCoinsBySymbols(coins);
      final data = coinsDetails.map((detail) {
        final coin = user.coins.firstWhere(
          (c) => c.info.symbol == detail.symbol,
        );
        return (details: detail, amount: coin.amount);
      }).toList();
      return data;
    });
