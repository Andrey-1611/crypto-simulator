import 'dart:async';
import 'package:Bitmark/data/models/app_user_details.dart';
import 'package:Bitmark/data/repositories/auth_repository.dart';
import 'package:Bitmark/data/repositories/remote_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends AsyncNotifier<AuthState> {
  @override
  FutureOr<AuthState> build() async {
    final authState = ref.read(authRepositoryProvider).getAuthState();
    if (authState == .emailNotVerified) {
      await ref.read(authRepositoryProvider).sendEmailVerification();
    }
    return authState;
  }

  Future<void> signIn(String email, String password) async {
    state = const AsyncLoading();
    state = await .guard(() async {
      final emailVerified = await ref
          .read(authRepositoryProvider)
          .signIn(email, password);
      if (emailVerified) {
        return .auth;
      } else {
        await ref.read(authRepositoryProvider).sendEmailVerification();
        return .emailNotVerified;
      }
    });
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    state = await .guard(() async {
      final user = await ref.read(authRepositoryProvider).signInWithGoogle();
      if (user != null) {
        final newUser = AppUserDetails.create(user);
        await ref.read(remoteRepositoryProvider).createUser(newUser);
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
      final newUser = AppUserDetails.create(user);
      await ref.read(remoteRepositoryProvider).createUser(newUser);
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
      final user = ref.read(authRepositoryProvider).getUser();
      await ref.read(remoteRepositoryProvider).deleteUser(user.id);
      await ref.read(authRepositoryProvider).signOut();
      return .notAuth;
    });
  }
}
