import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/crypto_repository.dart';
import '../../../data/repositories/remote_repository.dart';

final cryptoCoinsBalanceProvider = FutureProvider<double>((ref) async {
  final userId = await ref.read(authRepositoryProvider).getUserId();
  final user = await ref.read(remoteRepositoryProvider).getUserById(userId);
  final prices = await ref
      .read(cryptoRepositoryProvider)
      .getCoinsPricesBySymbols(user!.coinsSymbols);
  final balance = user.coins.fold(0.0, (sum, coin) {
    final price = prices.firstWhere(
      (p) => p.symbol == coin.info.symbol,
      orElse: () => (price: 0, symbol: ''),
    );
    return sum + (price.price * coin.amount);
  });
  return balance;
});
