import 'package:crypto_simulator/data/models/app_user.dart';
import 'package:crypto_simulator/data/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthDataSource implements AuthRepository {
  final FirebaseAuth _auth;

  AuthDataSource({required FirebaseAuth auth}) : _auth = auth;

  @override
  Future<String> getUserId() async {
    return 'test';
  }
}
