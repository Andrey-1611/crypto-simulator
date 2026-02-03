import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:crypto_simulator/app/router/app_router.dart';
import 'package:crypto_simulator/data/repositories/auth_repository.dart';
import 'package:crypto_simulator/features/auth/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthGuard extends AutoRouteGuard {
  final Ref _ref;

  AuthGuard({required Ref ref}) : _ref = ref;

  @override
  FutureOr<void> onNavigation(NavigationResolver resolver, StackRouter router) {
    final authState = _ref.read(authRepositoryProvider).getAuthState();
    if (authState == .auth) {
      resolver.next(true);
    } else if (authState == .emailNotVerified) {
      router.replaceAll([const EmailVerificationRoute()]);
    } else if (authState == .notAuth) {
      router.replaceAll([const SignInRoute()]);
    }
  }
}
