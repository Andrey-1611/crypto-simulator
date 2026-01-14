import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_simulator/data/models/app_user.dart';
import 'package:crypto_simulator/data/models/trade.dart';
import 'package:crypto_simulator/data/repositories/remote_repository.dart';

class RemoteDataSource implements RemoteRepository {
  final FirebaseFirestore _firestore;

  RemoteDataSource({required FirebaseFirestore firestore})
    : _firestore = firestore;

  CollectionReference _usersCollection() => _firestore.collection('users');

  @override
  Future<void> createUser(AppUser user) async {
    await _usersCollection().doc(user.id).set(user.toMap());
  }

  @override
  Future<AppUser?> getUserById(String userId) async {
    final doc = await _usersCollection().doc(userId).get();
    if (!doc.exists) return null;
    final user = AppUser.fromMap(doc.data() as Map<String, dynamic>);
    return user;
  }

  @override
  Future<void> updateUser(AppUser user) async {
    await _usersCollection().doc(user.id).update(user.toMap());
  }
}
