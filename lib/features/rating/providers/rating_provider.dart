import 'package:Bitmark/core/utils/validator.dart';
import 'package:Bitmark/data/models/app_user_details.dart';
import 'package:Bitmark/data/repositories/auth_repository.dart';
import 'package:Bitmark/data/repositories/crypto_repository.dart';
import 'package:Bitmark/data/repositories/remote_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ratingProvider = FutureProvider<UsersWithCurrentUserId>((ref) async {
  final currentUser = ref.read(authRepositoryProvider).getUser();
  final users = await ref.read(remoteRepositoryProvider).getUsers();
  final symbols = users
      .expand((u) => u.coins.map((c) => c.coin.symbol))
      .toList();
  final prices = await ref
      .read(cryptoRepositoryProvider)
      .getCoinsPricesBySymbols(symbols);
  final List<({AppUserDetails user, double fullBalance})> newUsers = users.map((
    u,
  ) {
    final coinsBalance = u.coinsBalance(prices);
    return (user: u, fullBalance: u.balance + coinsBalance);
  }).toList();
  newUsers.sort((a, b) => b.fullBalance.compareTo(a.fullBalance));
  return (users: newUsers, currentUserId: currentUser.id);
});
