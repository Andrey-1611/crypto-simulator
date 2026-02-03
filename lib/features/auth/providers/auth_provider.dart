import 'dart:async';
import 'package:crypto_simulator/data/models/app_user.dart';
import 'package:crypto_simulator/data/repositories/auth_repository.dart';
import 'package:crypto_simulator/data/repositories/remote_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends AsyncNotifier<AuthState> {
  @override
  FutureOr<AuthState> build() async {
    return ref.read(authRepositoryProvider).getAuthState();
  }

  Future<void> signIn(String email, String password) async {
    state = const AsyncLoading();
    state = await .guard(() async {
      final emailVerified = await ref
          .read(authRepositoryProvider)
          .signIn(email, password);
      if (emailVerified) return .auth;
      await ref.read(authRepositoryProvider).sendEmailVerification();
      return .emailNotVerified;
    });
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    state = await .guard(() async {
      final user = await ref.read(authRepositoryProvider).signInWithGoogle();
      if (user != null) {
        await ref.read(remoteRepositoryProvider).createUser(user);
      }
      return .auth;
    });
  }

  Future<void> signUp(String name, String email, String password) async {
    state = const AsyncLoading();
    state = await .guard(() async {
      final user = await ref
          .read(authRepositoryProvider)
          .signUp(name, email, password);
      await ref.read(remoteRepositoryProvider).createUser(user);
      await ref.read(authRepositoryProvider).sendEmailVerification();
      return .emailNotVerified;
    });
  }

  Future<void> signOut() async {
    state = await .guard(() async {
      await ref.read(authRepositoryProvider).signOut();
      return .notAuth;
    });
  }

  Future<void> sendEmailNotification() async {
    state = await .guard(() async {
      await ref.read(authRepositoryProvider).sendEmailVerification();
      return state.value!;
    });
  }

  Future<void> checkEmailVerification() async {
    state = await .guard(() async {
      final check = await ref
          .read(authRepositoryProvider)
          .checkEmailVerification();
      return check ? .auth : .emailNotVerified;
    });
  }

  Future<void> sendPasswordResetEmail(String email) async {
    state = const AsyncLoading();
    state = await .guard(() async {
      await ref.read(authRepositoryProvider).sendPasswordResetEmail(email);
      return state.value!;
    });
  }

  Future<void> deleteAccount() async {
    state = await .guard(() async {
      final userId = await ref.read(authRepositoryProvider).getUserId();
      await ref.read(remoteRepositoryProvider).deleteUser(userId);
      await ref.read(authRepositoryProvider).deleteAccount();
      return .notAuth;
    });
  }
}
