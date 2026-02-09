import 'package:Bitmark/app/runner/app_dependencies.dart';
import 'package:Bitmark/data/data_sources/auth_data_source.dart';
import 'package:Bitmark/data/models/app_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthDataSource(
    auth: ref.read(authProvider),
    google: ref.read(googleProvider),
  ),
);

abstract interface class AuthRepository {
  AppUser getUser();

  AuthState getAuthState();

  Future<bool> signIn(String email, String password);

  Future<AppUser?> signInWithGoogle();

  Future<AppUser> signUp(String name, String email, String password);

  Future<void> signOut();

  Future<void> sendEmailVerification();

  Future<bool> checkEmailVerification();

  Future<void> sendPasswordResetEmail(String email);

  Future<void> deleteAccount();
}

enum AuthState { auth, emailNotVerified, notAuth }
