import 'package:auto_route/auto_route.dart';
import 'package:crypto_simulator/app/router/auth_guard.dart';
import 'package:crypto_simulator/data/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import '../../data/models/app_user.dart';
import '../../data/models/crypto_coin.dart';
import '../../data/models/trade.dart';
import '../../features/auth/pages/sign_in_page.dart';
import '../../features/auth/pages/sign_up_page.dart';
import '../../features/briefcase/pages/briefcase_page.dart';
import '../../features/briefcase/pages/trade_page.dart';
import '../../features/home/home_page.dart';
import '../../features/market/pages/crypto_coin_page.dart';
import '../../features/market/pages/market_page.dart';
import '../../features/rating/pages/rating_page.dart';
import '../../features/settings/pages/settings_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  final AuthRepository _authRepository;
  late final AuthGuard _authGuard;

  AppRouter({required AuthRepository authRepository})
    : _authRepository = authRepository {
    _authGuard = AuthGuard(authRepository: _authRepository);
  }

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: HomeRoute.page,
      initial: true,
      guards: [_authGuard],
      children: [
        AutoRoute(page: MarketRoute.page),
        AutoRoute(page: BriefcaseRoute.page),
        AutoRoute(page: RatingRoute.page),
      ],
    ),
    AutoRoute(page: SettingsRoute.page),
    AutoRoute(page: CryptoCoinRoute.page),
    AutoRoute(page: TradeRoute.page),
    AutoRoute(page: BriefcaseRoute.page),
    AutoRoute(page: SignInRoute.page),
    AutoRoute(page: SignUpRoute.page),
  ];
}
