import 'package:auto_route/annotations.dart';
import 'package:crypto_simulator/app/widgets/settings_button.dart';
import 'package:crypto_simulator/data/models/app_user.dart';
import 'package:crypto_simulator/features/briefcase/pages/balance_page.dart';
import 'package:crypto_simulator/features/briefcase/pages/crypto_coins_page.dart';
import 'package:crypto_simulator/features/briefcase/pages/trades_history_page.dart';
import 'package:crypto_simulator/features/briefcase/widgets/keep_alive.dart';
import 'package:crypto_simulator/generated/l10n.dart';
import 'package:flutter/material.dart';

@RoutePage()
class BriefcasePage extends StatelessWidget {
  final AppUser? user;

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
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Баланс'),
              Tab(text: 'Монеты'),
              Tab(text: 'Операции'),
            ],
          ),
        ),
        body: Padding(
          padding: const .all(16),
          child: TabBarView(
            children: [
              KeepAliveWrapper(child: BalancePage(user: user)),
              KeepAliveWrapper(child: CryptoCoinsPage(user: user)),
              KeepAliveWrapper(child: TradesHistoryPage(userA: user)),
            ],
          ),
        ),
      ),
    );
  }
}
