import 'package:crypto_simulator/core/utils/validator.dart';
import 'package:crypto_simulator/data/models/app_user.dart';
import 'package:crypto_simulator/data/repositories/auth_repository.dart';
import 'package:crypto_simulator/data/repositories/crypto_repository.dart';
import 'package:crypto_simulator/data/repositories/remote_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ratingProvider = FutureProvider<UsersWithCurrentUserId>((ref) async {
  final currentUserId = await ref.read(authRepositoryProvider).getUserId();
  final users = await ref.read(remoteRepositoryProvider).getUsers();
  final symbols = users
      .expand((u) => u.coins.map((c) => c.info.symbol))
      .toList();
  final prices = await ref
      .read(cryptoRepositoryProvider)
      .getCoinsPricesBySymbols(symbols);
  final List<({AppUser user, double fullBalance})> newUsers = users.map((u) {
    final coinsBalance = u.coinsBalance(prices);
    return (user: u, fullBalance: u.balance + coinsBalance);
  }).toList();
  return (users: newUsers, currentUserId: currentUserId);
});
