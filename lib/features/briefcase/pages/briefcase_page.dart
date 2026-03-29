import 'package:Bitmark/app/router/app_router.dart';
import 'package:Bitmark/core/utils/export_service.dart';
import 'package:Bitmark/core/utils/extensions.dart';
import 'package:Bitmark/data/models/coin_amount_price.dart';
import 'package:Bitmark/features/briefcase/pages/favourite_coins_page.dart';
import 'package:Bitmark/app/widgets/settings_button.dart';
import 'package:Bitmark/data/models/app_user_details.dart';
import 'package:Bitmark/features/briefcase/pages/balance_page.dart';
import 'package:Bitmark/features/briefcase/pages/crypto_coins_page.dart';
import 'package:Bitmark/features/briefcase/providers/crypto_coins_provider.dart';
import 'package:Bitmark/features/briefcase/providers/filter_coins_provider.dart';
import 'package:Bitmark/features/briefcase/widgets/filter_coins_sheet.dart';
import 'package:Bitmark/features/briefcase/widgets/keep_alive.dart';
import 'package:Bitmark/features/briefcase/widgets/sort_coins_sheet.dart';
import 'package:Bitmark/generated/l10n.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../history/pages/history_page.dart';

@RoutePage()
class BriefcasePage extends ConsumerWidget {
  final AppUserDetails? user;

  const BriefcasePage({super.key, this.user});

  bool get isCurrentUser => user == null;

  void showSortSheet(BuildContext context) => showModalBottomSheet(
    context: context,
    builder: (context) => const SortCoinsSheet(),
  );

  void showFilterSheet(BuildContext context) => showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => const FilterCoinsSheet(),
  );

  void reset(WidgetRef ref) {
    ref.invalidate(filterCoinsProvider);
    ref.invalidate(filterCoinsOnSheetProvider);
  }

  void export(WidgetRef ref, List<CoinAmountPrice> coins) =>
      ref.read(exportServiceProvider).exportCoins(coins);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    return DefaultTabController(
      length: isCurrentUser ? 3 : 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(s.briefcase),
          automaticallyImplyLeading: !isCurrentUser,
          leading: isCurrentUser
              ? ref.watchWhenData(
                  cryptoCoinsProvider(user),
                  builder: (data) => IconButton(
                    onPressed: () => export(ref, data.coins),
                    icon: const Icon(Icons.share),
                  ),
                )
              : null,
          actions: [
            PopupMenuButton<PopupMenuType>(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) => switch (value) {
                .filter => showFilterSheet(context),
                .sort => showSortSheet(context),
                .reset => reset(ref),
              },
              itemBuilder: (context) => [
                PopupMenuItem(value: .filter, child: Text(s.filters)),
                PopupMenuItem(value: .sort, child: Text(s.sorting)),
                PopupMenuItem(value: .reset, child: Text(s.reset)),
              ],
            ),
            isCurrentUser
                ? const SettingsButton()
                : IconButton(
                    onPressed: () =>
                        context.pushRoute(HistoryRoute(user: user)),
                    icon: const Icon(Icons.receipt_long),
                  ),
          ],
          bottom: TabBar(
            indicatorSize: .tab,
            dividerColor: Colors.transparent,
            tabs: [
              Tab(text: s.balance),
              Tab(text: s.coins),
              if (isCurrentUser) Tab(text: s.favourite),
            ],
          ),
        ),
        body: Padding(
          padding: .all(16.sp),
          child: TabBarView(
            children: [
              KeepAliveWrapper(child: BalancePage(user: user)),
              KeepAliveWrapper(child: CryptoCoinsPage(user: user)),
              if (isCurrentUser)
                const KeepAliveWrapper(child: FavouriteCoinsPage()),
            ],
          ),
        ),
      ),
    );
  }
}
