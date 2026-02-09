import 'package:Bitmark/data/models/trade.dart';
import 'package:Bitmark/data/repositories/auth_repository.dart';
import 'package:Bitmark/data/repositories/remote_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tradesProvider = FutureProvider.family<List<Trade>, String?>((
  ref,
  userId,
) async {
  if (userId == null) {
    final authUser = ref.read(authRepositoryProvider).getUser();
    userId = authUser.id;
  }
  return await ref.read(remoteRepositoryProvider).getTrades(userId);
});
