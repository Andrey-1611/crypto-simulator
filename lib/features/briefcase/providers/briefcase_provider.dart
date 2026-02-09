import 'dart:async';
import 'package:Bitmark/data/models/app_user_details.dart';
import 'package:Bitmark/features/briefcase/providers/trades_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/crypto_coin.dart';
import '../../../data/models/trade.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/remote_repository.dart';
import 'crypto_balance_provider.dart';
import 'crypto_coins_details_provider.dart';

final briefcaseNotifierProvider =
    AsyncNotifierProvider.family<
      BriefcaseNotifier,
      AppUserDetails,
      AppUserDetails?
    >((user) => BriefcaseNotifier(user: user));

class BriefcaseNotifier extends AsyncNotifier<AppUserDetails> {
  final AppUserDetails? user;

  BriefcaseNotifier({this.user});

  @override
  FutureOr<AppUserDetails> build() async {
    if (user != null) return user!;
    final authUser = ref.read(authRepositoryProvider).getUser();
    final newUser = await ref
        .read(remoteRepositoryProvider)
        .getUserById(authUser.id);
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
      final authUser = ref.read(authRepositoryProvider).getUser();
      final user = await ref
          .read(remoteRepositoryProvider)
          .getUserById(authUser.id);
      final updatedUser = trade.type == TradeType.buy
          ? AppUserDetails.buyCoins(user, trade)
          : AppUserDetails.sellCoins(user, trade);
      await ref.read(remoteRepositoryProvider).addTrade(updatedUser, trade);
      ref.invalidate(cryptoCoinsDetailsProvider);
      ref.invalidate(cryptoBalanceProvider);
      ref.invalidate(tradesProvider);
      return updatedUser;
    });
  }
}
