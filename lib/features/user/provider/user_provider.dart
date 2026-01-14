import 'dart:async';
import 'package:crypto_simulator/data/models/app_user.dart';
import 'package:crypto_simulator/data/repositories/auth_repository.dart';
import 'package:crypto_simulator/data/repositories/remote_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/trade.dart';

final userNotifierProvider = AsyncNotifierProvider<UserNotifier, AppUser?>(
  UserNotifier.new,
);

class UserNotifier extends AsyncNotifier<AppUser?> {
  @override
  FutureOr<AppUser?> build() async {
    final userId = await ref.read(authRepositoryProvider).getUserId();
    final user = await ref.read(remoteRepositoryProvider).getUserById(userId);
    return user;
  }

  Future<void> createTrade({
    required String coinSymbol,
    required double coinPrice,
    required int amount,
    required TradeType type,
  }) async {
    final trade = Trade.create(
      coinSymbol: coinSymbol,
      coinPrice: coinPrice,
      amount: amount,
      type: type,
    );
    state = await AsyncValue.guard(() async {
      final userId = await ref.read(authRepositoryProvider).getUserId();
      final user = await ref.read(remoteRepositoryProvider).getUserById(userId);
      final updatedUser = AppUser.addTrade(user!, trade);
      await ref.read(remoteRepositoryProvider).updateUser(updatedUser);
      return updatedUser;
    });
  }
}
