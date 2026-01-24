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
    return AutoTabsRouter(
      routes: [const MarketRoute(), BriefcaseRoute(), const RatingRoute()],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: NavigationBar(
            selectedIndex: tabsRouter.activeIndex,
            onDestinationSelected: tabsRouter.setActiveIndex,
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.currency_exchange),
                label: s.market,
              ),
              NavigationDestination(
                icon: const Icon(Icons.wallet),
                label: s.briefcase,
              ),
              NavigationDestination(
                icon: const Icon(Icons.leaderboard),
                label: s.rating,
              ),
            ],
          ),
          /*bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.currency_exchange),
                label: s.market,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.wallet),
                label: s.briefcase,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.leaderboard),
                label: s.rating,
              ),
            ],
          ),*/
        );
      },
    );
  }
}
