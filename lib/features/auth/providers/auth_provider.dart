import 'dart:async';
import 'package:crypto_simulator/data/repositories/auth_repository.dart';
import 'package:crypto_simulator/data/repositories/remote_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, bool>(
  AuthNotifier.new,
);

class AuthNotifier extends AsyncNotifier<bool> {
  @override
  FutureOr<bool> build() async {
    return await ref.read(authRepositoryProvider).isUserAuth();
  }

  Future<void> signIn(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider).signIn(email, password);
      return true;
    });
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final user = await ref.read(authRepositoryProvider).signInWithGoogle();
      if (user != null) {
        await ref.read(remoteRepositoryProvider).createUser(user);
      }
      return true;
    });
  }

  Future<void> signUp(String name, String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final user = await ref
          .read(authRepositoryProvider)
          .signUp(name, email, password);
      await ref.read(remoteRepositoryProvider).createUser(user);
      return true;
    });
  }

  Future<void> signOut() async {
    state = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider).signOut();
      return false;
    });
  }
}
