import 'package:crypto_simulator/data/models/app_user.dart';
import 'package:crypto_simulator/features/briefcase/providers/briefcase_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories/crypto_repository.dart';

final cryptoBalanceProvider = FutureProvider.family<double, AppUser?>((
  ref,
  user,
) async {
  user = await ref.read(briefcaseNotifierProvider(user).future);
  final prices = await ref
      .read(cryptoRepositoryProvider)
      .getCoinsPricesBySymbols(user!.coinsSymbols);
  final balance = user.coinsBalance(prices);
  return balance;
});
