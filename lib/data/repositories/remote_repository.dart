import 'package:Bitmark/app/runner/app_dependencies.dart';
import 'package:Bitmark/data/data_sources/remote_data_source.dart';
import 'package:Bitmark/data/models/app_user_details.dart';
import 'package:Bitmark/data/models/crypto_coin.dart';
import 'package:Bitmark/data/models/trade.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final remoteRepositoryProvider = Provider<RemoteRepository>((ref) {
  return RemoteDataSource(firestore: ref.read(firestoreProvider));
});

abstract interface class RemoteRepository {
  Future<AppUserDetails> getUserById(String userId);

  Future<void> createUser(AppUserDetails user);

  Future<List<AppUserDetails>> getUsers();

  Future<void> addTrade(AppUserDetails user, Trade trade);

  Future<List<Trade>> getTrades(String userId);

  Future<void> deleteUser(String userId);

  Future<List<CryptoCoin>> getFavouriteCoins(String userId);

  Future<void> setFavouriteCoins(String userId, List<CryptoCoin> coins);
}
