import 'package:crypto_simulator/data/models/app_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/crypto_repository.dart';
import '../../../data/repositories/remote_repository.dart';

final cryptoCoinsBalanceProvider = FutureProvider.family<double, AppUser?>((
  ref,
  user,
) async {
  if (user == null) {
    final userId = await ref.read(authRepositoryProvider).getUserId();
    user = await ref.read(remoteRepositoryProvider).getUserById(userId);
  }
  final prices = await ref
      .read(cryptoRepositoryProvider)
      .getCoinsPricesBySymbols(user.coinsSymbols);
  final balance = user.coinsBalance(prices);
  return balance;
});
