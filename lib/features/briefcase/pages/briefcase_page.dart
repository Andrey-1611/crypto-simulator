import 'package:Bitmark/app/router/app_router.dart';
import 'package:Bitmark/features/briefcase/pages/favourite_coins_page.dart';
import 'package:Bitmark/app/widgets/settings_button.dart';
import 'package:Bitmark/data/models/app_user_details.dart';
import 'package:Bitmark/features/briefcase/pages/balance_page.dart';
import 'package:Bitmark/features/briefcase/pages/crypto_coins_page.dart';
import 'package:Bitmark/features/briefcase/widgets/keep_alive.dart';
import 'package:Bitmark/generated/l10n.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class BriefcasePage extends StatelessWidget {
  final AppUserDetails? user;

  const BriefcasePage({super.key, this.user});

  bool get userIsNull => user == null;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return DefaultTabController(
      length: userIsNull ? 3 : 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(s.briefcase),
          automaticallyImplyLeading: !userIsNull,
          actions: [
            userIsNull
                ? const SettingsButton()
                : IconButton(
                    onPressed: () =>
                        context.pushRoute(HistoryRoute(user: user)),
                    icon: const Icon(Icons.receipt_long),
                  ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: s.balance),
              Tab(text: s.coins),
              if (userIsNull) const Tab(text: 'Избранное'),
            ],
          ),
        ),
        body: Padding(
          padding: .all(16.sp),
          child: TabBarView(
            children: [
              KeepAliveWrapper(child: BalancePage(user: user)),
              KeepAliveWrapper(child: CryptoCoinsPage(user: user)),
              if (userIsNull)
                const KeepAliveWrapper(child: FavouriteCoinsPage()),
            ],
          ),
        ),
      ),
    );
  }
}
