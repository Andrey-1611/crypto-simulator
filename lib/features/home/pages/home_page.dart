import 'package:auto_route/auto_route.dart';
import 'package:crypto_simulator/app/router/app_router.dart';
import 'package:crypto_simulator/generated/l10n.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final tabs = [s.market, s.briefcase, s.favourite, s.rating];
    return AutoTabsRouter(
      routes: const [
        MarketRoute(),
        BriefcaseRoute(),
        FavouritesRoute(),
        RatingRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(tabs[tabsRouter.activeIndex]),
            actions: [
              IconButton(
                onPressed: () => context.pushRoute(const SettingsRoute()),
                icon: const Icon(Icons.settings),
              ),
            ],
          ),
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.currency_exchange),
                label: tabs[0],
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.wallet),
                label: tabs[1],
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.star),
                label: tabs[2],
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.leaderboard),
                label: tabs[3],
              ),
            ],
          ),
        );
      },
    );
  }
}
