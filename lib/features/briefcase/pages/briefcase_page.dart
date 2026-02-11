import 'package:auto_route/annotations.dart';
import 'package:Bitmark/app/widgets/settings_button.dart';
import 'package:Bitmark/data/models/app_user_details.dart';
import 'package:Bitmark/features/briefcase/pages/balance_page.dart';
import 'package:Bitmark/features/briefcase/pages/crypto_coins_page.dart';
import 'package:Bitmark/features/briefcase/pages/trades_history_page.dart';
import 'package:Bitmark/features/briefcase/widgets/keep_alive.dart';
import 'package:Bitmark/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class BriefcasePage extends StatelessWidget {
  final AppUserDetails? user;

  const BriefcasePage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(s.briefcase),
          automaticallyImplyLeading: user != null,
          actions: user == null ? [const SettingsButton()] : [],
          bottom: TabBar(
            tabs: [
              Tab(text: s.balance),
              Tab(text: s.coins),
              Tab(text: s.trades),
            ],
          ),
        ),
        body: Padding(
          padding: .all(16.sp),
          child: TabBarView(
            children: [
              KeepAliveWrapper(child: BalancePage(user: user)),
              KeepAliveWrapper(child: CryptoCoinsPage(user: user)),
              KeepAliveWrapper(child: TradesHistoryPage(user: user)),
            ],
          ),
        ),
      ),
    );
  }
}
