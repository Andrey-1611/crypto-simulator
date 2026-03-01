import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:Bitmark/data/data_sources/remote_data_source.dart';
import 'package:Bitmark/data/models/app_user_details.dart';
import 'package:Bitmark/data/models/trade.dart';
import 'package:Bitmark/data/models/crypto_coin.dart';
import '../mock_data.dart';

void main() {
  late RemoteDataSource remoteDataSource;
  late FakeFirebaseFirestore fakeFirestore;
  late CollectionReference usersCollection;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    usersCollection = fakeFirestore.collection('users');
    remoteDataSource = RemoteDataSource(firestore: fakeFirestore);
  });

  group('RemoteDataSource Tests', () {
    test('createUser(AppUserDetails user)', () async {
      await remoteDataSource.createUser(MockData.userDetails);
      final doc = await usersCollection.doc(MockData.userDetails.id).get();
      expect(doc.exists, true);
      expect(doc.data(), equals(MockData.userDetails.toJson()));
    });

    test('getUserById(String userId)', () async {
      await remoteDataSource.createUser(MockData.userDetails);

      final user = await remoteDataSource.getUserById(MockData.userDetails.id);

      expect(user.name, MockData.userDetails.name);
    });

    test('getUsers()', () async {
      await remoteDataSource.createUser(MockData.userDetails);
      await remoteDataSource.createUser(MockData.userDetails);
      final users = await remoteDataSource.getUsers();
      expect(users, isA<List<AppUserDetails>>());
    });

    test('addTrade(AppUserDetails user, Trade trade)', () async {
      await remoteDataSource.createUser(MockData.userDetails);
      await remoteDataSource.addTrade(MockData.userDetails, MockData.trade);

      final trades = await remoteDataSource.getTrades(MockData.userDetails.id);
      expect(trades, isA<List<Trade>>());
    });

    test('getTrades(String userId)', () async {
      await remoteDataSource.createUser(MockData.userDetails);
      await remoteDataSource.addTrade(MockData.userDetails, MockData.trade);

      final trades = await remoteDataSource.getTrades(MockData.userDetails.id);
      expect(trades, isA<List<Trade>>());
    });

    test('deleteUser(String userId)', () async {
      await remoteDataSource.createUser(MockData.userDetails);
      await remoteDataSource.deleteUser(MockData.userDetails.id);
      final doc = await usersCollection.doc(MockData.userDetails.id).get();
      expect(doc.exists, false);
    });

    test('getFavouriteCoins(String userId)', () async {
      await remoteDataSource.createUser(MockData.userDetails);
      await remoteDataSource.setFavouriteCoins(MockData.userDetails.id, []);

      final favouriteCoins = await remoteDataSource.getFavouriteCoins(
        MockData.userDetails.id,
      );
      expect(favouriteCoins, isA<List<CryptoCoin>>());
    });

    test('setFavouriteCoins(String userId, List<CryptoCoin> coins)', () async {
      await remoteDataSource.createUser(MockData.userDetails);
      await remoteDataSource.setFavouriteCoins(MockData.userDetails.id, []);

      final favouriteCoins = await remoteDataSource.getFavouriteCoins(
        MockData.userDetails.id,
      );
      expect(favouriteCoins, isA<List<CryptoCoin>>());
    });
  });
}
