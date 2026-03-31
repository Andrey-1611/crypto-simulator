import 'dart:async';
import 'package:Bitmark/data/models/app_user_details.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/crypto_coin.dart';
import '../../../data/models/trade.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/crypto_repository.dart';
import '../../../data/repositories/remote_repository.dart';
import 'crypto_coins_provider.dart';

final briefcaseNotifierProvider =
    AsyncNotifierProvider.family<
      BriefcaseNotifier,
      BriefcaseState,
      AppUserDetails?
    >((user) => BriefcaseNotifier(user: user));

class BriefcaseNotifier extends AsyncNotifier<BriefcaseState> {
  final AppUserDetails? user;

  BriefcaseNotifier({this.user});

  @override
  FutureOr<BriefcaseState> build() async {
    AppUserDetails details;
    if (user != null) {
      details = user!;
    } else {
      final authUser = ref.read(authRepositoryProvider).getUser();
      details = await ref
          .read(remoteRepositoryProvider)
          .getUserById(authUser.id);
    }
    final trades = await ref
        .read(remoteRepositoryProvider)
        .getTrades(details.id);
    final prices = await ref
        .read(cryptoRepositoryProvider)
        .getCoinsPricesBySymbols(details.coinsSymbols);
    final balance = details.coinsBalance(prices);
    return BriefcaseState(user: details, trades: trades, coinsBalance: balance);
  }

  Future<void> createTrade({
    required CryptoCoin coin,
    required int amount,
    required TradeType type,
  }) async {
    final coinPrice = await ref
        .read(cryptoRepositoryProvider)
        .getCoinPriceBySymbol(coin.symbol);
    final trade = Trade.create(
      coin: coin,
      coinPrice: coinPrice,
      amount: amount,
      type: type,
    );
    final previous = state.requireValue;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final authUser = ref.read(authRepositoryProvider).getUser();
      final user = await ref
          .read(remoteRepositoryProvider)
          .getUserById(authUser.id);
      final updatedUser = trade.type == .buy
          ? AppUserDetails.buyCoins(user, trade)
          : AppUserDetails.sellCoins(user, trade);
      final balance = updatedUser.updateCoinsBalance(
        trade,
        previous.coinsBalance,
      );
      await ref.read(remoteRepositoryProvider).addTrade(updatedUser, trade);
      ref.invalidate(cryptoCoinsProvider);
      return previous.copyWith(
        user: updatedUser,
        coinsBalance: balance,
        trades: [trade, ...previous.trades],
      );
    });
  }
}

class BriefcaseState {
  final AppUserDetails user;
  final List<Trade> trades;
  final double coinsBalance;

  BriefcaseState({
    required this.user,
    required this.trades,
    required this.coinsBalance,
  });

  BriefcaseState copyWith({
    AppUserDetails? user,
    List<Trade>? trades,
    double? coinsBalance,
  }) {
    return BriefcaseState(
      user: user ?? this.user,
      trades: trades ?? this.trades,
      coinsBalance: coinsBalance ?? this.coinsBalance,
    );
  }
}
