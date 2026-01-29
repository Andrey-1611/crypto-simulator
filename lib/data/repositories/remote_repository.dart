import 'package:crypto_simulator/app/runner/app_dependencies.dart';
import 'package:crypto_simulator/data/data_sources/remote_data_source.dart';
import 'package:crypto_simulator/data/models/app_user.dart';
import 'package:crypto_simulator/data/models/trade.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final remoteRepositoryProvider = Provider<RemoteRepository>((ref) {
  return RemoteDataSource(firestore: ref.read(firestoreProvider));
});

abstract interface class RemoteRepository {
  Future<AppUser> getUserById(String userId);

  Future<AppUser?> getUserOrNullById(String userId);

  Future<void> createUser(AppUser user);

  Future<List<AppUser>> getUsers();

  Future<void> addTrade(AppUser user, Trade trade);

  Future<List<Trade>> getTrades(String userId);
}
