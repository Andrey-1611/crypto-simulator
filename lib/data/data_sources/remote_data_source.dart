import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_simulator/data/models/app_user.dart';
import 'package:crypto_simulator/data/models/trade.dart';
import 'package:crypto_simulator/data/repositories/remote_repository.dart';
import '../../core/constants/databases_constants.dart';

class RemoteDataSource implements RemoteRepository {
  final FirebaseFirestore _firestore;

  RemoteDataSource({required FirebaseFirestore firestore})
    : _firestore = firestore;

  CollectionReference _usersCollection() =>
      _firestore.collection(DatabasesConstants.userCollection);

  CollectionReference _tradesCollection(String userId) =>
      _usersCollection().doc(userId).collection('trades');

  @override
  Future<void> createUser(AppUser user) async {
    await _usersCollection().doc(user.id).set(user.toJson());
  }

  @override
  Future<AppUser> getUserById(String userId) async {
    final doc = await _usersCollection().doc(userId).get();
    final user = AppUser.fromJson(doc.data() as Map<String, dynamic>);
    return user;
  }

  @override
  Future<AppUser?> getUserOrNullById(String userId) async {
    final doc = await _usersCollection().doc(userId).get();
    if (!doc.exists) return null;
    final user = AppUser.fromJson(doc.data() as Map<String, dynamic>);
    return user;
  }

  @override
  Future<List<AppUser>> getUsers() async {
    final data = await _usersCollection().limit(100).get();
    final users = data.docs
        .map((doc) => AppUser.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    return users;
  }

  @override
  Future<void> addTrade(AppUser user, Trade trade) async {
    final batch = _firestore.batch();
    final userDoc = _usersCollection().doc(user.id);
    final tradeDoc = _tradesCollection(user.id).doc(trade.id);
    batch.update(userDoc, user.toJson());
    batch.set(tradeDoc, trade.toJson());
    await batch.commit();
  }

  @override
  Future<List<Trade>> getTrades(String userId) async {
    final data = await _tradesCollection(userId).get();
    final trades = data.docs
        .map((doc) => Trade.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    return trades;
  }

  @override
  Future<void> deleteUser(String userId) async {
    await _usersCollection().doc(userId).delete();
  }
}
