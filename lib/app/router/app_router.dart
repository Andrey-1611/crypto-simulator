import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/app_user_details.dart';
import '../../data/models/crypto_coin.dart';
import '../../data/models/trade.dart';
import '../../features/auth/pages/email_verification_page.dart';
import '../../features/auth/pages/reset_password_page.dart';
import '../../features/auth/pages/sign_in_page.dart';
import '../../features/auth/pages/sign_up_page.dart';
import '../../features/briefcase/pages/briefcase_page.dart';
import '../../features/history/pages/history_page.dart';
import '../../features/history/pages/trade_page.dart';
import '../../features/home/home_page.dart';
import '../../features/market/pages/crypto_coin_page.dart';
import '../../features/market/pages/market_page.dart';
import '../../features/rating/pages/rating_page.dart';
import '../../features/settings/pages/settings_page.dart';
import 'auth_guard.dart';

part 'app_router.gr.dart';

final appRouterProvider = Provider((ref) => AppRouter(ref: ref));

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  final Ref _ref;
  late final AuthGuard _authGuard;

  AppRouter({required Ref ref}) : _ref = ref {
    _authGuard = AuthGuard(ref: _ref);
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
        AutoRoute(page: HistoryRoute.page),
        AutoRoute(page: RatingRoute.page),
      ],
    ),
    AutoRoute(page: SettingsRoute.page),
    AutoRoute(page: CryptoCoinRoute.page),
    AutoRoute(page: TradeRoute.page),
    AutoRoute(page: BriefcaseRoute.page),
    AutoRoute(page: HistoryRoute.page),
    AutoRoute(page: SignInRoute.page),
    AutoRoute(page: SignUpRoute.page),
    AutoRoute(page: EmailVerificationRoute.page),
    AutoRoute(page: ResetPasswordRoute.page),
  ];
}
