import 'package:Bitmark/data/models/app_user_details.dart';
import 'package:Bitmark/features/briefcase/providers/briefcase_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories/crypto_repository.dart';

final cryptoBalanceProvider = FutureProvider.family<double, AppUserDetails?>((
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
