import 'package:auto_route/auto_route.dart';
import '../../features/briefcase/pages/briefcase_page.dart';
import '../../features/favourite/pages/favourite_page.dart';
import '../../features/home/pages/home_page.dart';
import '../../features/market/pages/market_page.dart';
import '../../features/rating/pages/rating_page.dart';
import '../../features/settings/pages/settings_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: HomeRoute.page,
      initial: true,
      children: [
        AutoRoute(page: MarketRoute.page),
        AutoRoute(page: BriefcaseRoute.page),
        AutoRoute(page: FavouritesRoute.page),
        AutoRoute(page: RatingRoute.page),
      ],
    ),
    AutoRoute(page: SettingsRoute.page),
  ];
}
