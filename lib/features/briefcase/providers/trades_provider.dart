import 'package:crypto_simulator/data/models/trade.dart';
import 'package:crypto_simulator/data/repositories/auth_repository.dart';
import 'package:crypto_simulator/data/repositories/remote_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tradesProvider = FutureProvider.family<List<Trade>, String?>((
  ref,
  userId,
) async {
  userId ??= await ref.read(authRepositoryProvider).getUserId();
  return await ref.read(remoteRepositoryProvider).getTrades(userId);
});
