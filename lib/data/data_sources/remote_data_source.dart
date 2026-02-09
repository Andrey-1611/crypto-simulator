import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constants/databases_constants.dart';
import '../models/app_user_details.dart';
import '../models/trade.dart';
import '../repositories/remote_repository.dart';

class RemoteDataSource implements RemoteRepository {
  final FirebaseFirestore _firestore;

  RemoteDataSource({required FirebaseFirestore firestore})
    : _firestore = firestore;

  CollectionReference _usersCollection() =>
      _firestore.collection(DatabasesConstants.users);

  CollectionReference _tradesCollection(String userId) =>
      _usersCollection().doc(userId).collection(DatabasesConstants.trades);

  @override
  Future<void> createUser(AppUserDetails user) async {
    await _usersCollection().doc(user.id).set(user.toJson());
  }

  @override
  Future<AppUserDetails> getUserById(String userId) async {
    final doc = await _usersCollection().doc(userId).get();
    final user = AppUserDetails.fromJson(doc.data() as Map<String, dynamic>);
    return user;
  }

  @override
  Future<List<AppUserDetails>> getUsers() async {
    final data = await _usersCollection().limit(100).get();
    final users = data.docs
        .map(
          (doc) => AppUserDetails.fromJson(doc.data() as Map<String, dynamic>),
        )
        .toList();
    return users;
  }

  @override
  Future<void> addTrade(AppUserDetails user, Trade trade) async {
    await _usersCollection().doc(user.id).update(user.toJson());
    await _tradesCollection(user.id).doc(trade.id).set(trade.toJson());
  }

  @override
  Future<List<Trade>> getTrades(String userId) async {
    final data = await _tradesCollection(
      userId,
    ).orderBy('createdAt', descending: true).get();
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
