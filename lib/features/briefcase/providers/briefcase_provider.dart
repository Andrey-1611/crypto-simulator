import 'dart:async';
import 'package:crypto_simulator/features/briefcase/providers/trades_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/app_user.dart';
import '../../../data/models/crypto_coin.dart';
import '../../../data/models/trade.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/remote_repository.dart';
import 'crypto_balance_provider.dart';
import 'crypto_coins_details_provider.dart';

final briefcaseNotifierProvider =
    AsyncNotifierProvider.family<BriefcaseNotifier, AppUser, AppUser?>(
      (user) => BriefcaseNotifier(user: user),
    );

class BriefcaseNotifier extends AsyncNotifier<AppUser> {
  final AppUser? user;

  BriefcaseNotifier({this.user});

  @override
  FutureOr<AppUser> build() async {
    if (user != null) return user!;
    final userId = await ref.read(authRepositoryProvider).getUserId();
    final newUser = await ref
        .read(remoteRepositoryProvider)
        .getUserById(userId);
    return newUser;
  }

  Future<void> createTrade({
    required CryptoCoin coin,
    required double coinPrice,
    required int amount,
    required TradeType type,
  }) async {
    final trade = Trade.create(
      coin: coin,
      coinPrice: coinPrice,
      amount: amount,
      type: type,
    );
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final userId = await ref.read(authRepositoryProvider).getUserId();
      final user = await ref.read(remoteRepositoryProvider).getUserById(userId);
      final updatedUser = trade.type == TradeType.buy
          ? AppUser.buyCoins(user, trade)
          : AppUser.sellCoins(user, trade);
      await ref.read(remoteRepositoryProvider).addTrade(updatedUser, trade);
      ref.invalidate(cryptoCoinsDetailsProvider);
      ref.invalidate(cryptoBalanceProvider);
      ref.invalidate(tradesProvider);
      return updatedUser;
    });
  }
}
