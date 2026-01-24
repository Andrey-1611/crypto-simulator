import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_simulator/data/models/app_user.dart';
import 'package:crypto_simulator/data/repositories/remote_repository.dart';

class RemoteDataSource implements RemoteRepository {
  final FirebaseFirestore _firestore;

  RemoteDataSource({required FirebaseFirestore firestore})
    : _firestore = firestore;

  CollectionReference _usersCollection() => _firestore.collection('users');

  @override
  Future<void> createUser(AppUser user) async {
    await _usersCollection().doc(user.id).set(user.toJson());
  }

  @override
  Future<AppUser> getUserById(String userId) async {
    final doc = await _usersCollection().doc(userId).get();
    final user = AppUser.fromJson(doc.data() as Map<String, dynamic>);
    user.trades.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return user;
  }

  @override
  Future<AppUser?> getUserOrNullById(String userId) async {
    final doc = await _usersCollection().doc(userId).get();
    if (!doc.exists) return null;
    final user = AppUser.fromJson(doc.data() as Map<String, dynamic>);
    user.trades.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return user;
  }

  @override
  Future<void> updateUser(AppUser user) async {
    await _usersCollection().doc(user.id).update(user.toJson());
  }

  @override
  Future<List<AppUser>> getUsers() async {
    final data = await _usersCollection().limit(100).get();
    final users = data.docs
        .map((doc) => AppUser.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    return users;
  }
}
