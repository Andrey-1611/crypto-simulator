import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:crypto_simulator/app/router/app_router.dart';
import 'package:crypto_simulator/data/repositories/auth_repository.dart';

class AuthGuard extends AutoRouteGuard {
  final AuthRepository _authRepository;

  AuthGuard({required AuthRepository authRepository})
    : _authRepository = authRepository;

  @override
  FutureOr<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final isAuth = await _authRepository.isUserAuth();
    if (isAuth) {
      resolver.next(true);
    } else {
      resolver.next(false);
      router.replaceAll([const SignInRoute()]);
    }
  }
}
