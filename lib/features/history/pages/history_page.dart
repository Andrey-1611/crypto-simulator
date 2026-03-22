import 'package:Bitmark/app/widgets/settings_button.dart';
import 'package:Bitmark/app/widgets/trade_card.dart';
import 'package:Bitmark/core/utils/export_service.dart';
import 'package:Bitmark/core/utils/extensions.dart';
import 'package:Bitmark/data/models/trade.dart';
import 'package:Bitmark/features/history/providers/filter_trades_provider.dart';
import 'package:Bitmark/features/history/providers/trades_provider.dart';
import 'package:Bitmark/features/history/widgets/filter_trades_sheet.dart';
import 'package:Bitmark/features/history/widgets/sort_trades_sheet.dart';
import 'package:auto_route/auto_route.dart';
import 'package:Bitmark/app/widgets/unknown_error.dart';
import 'package:Bitmark/data/models/app_user_details.dart';
import 'package:Bitmark/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/widgets/loader.dart';

@RoutePage()
class HistoryPage extends ConsumerWidget {
  final AppUserDetails? user;

  const HistoryPage({super.key, this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tradesP = ref.watch(tradesProvider(user));
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: _AppBar(size: .fromHeight(size.height * 0.07), user: user),
      body: Center(
        child: Padding(
          padding: .all(16.sp),
          child: tradesP.when(
            data: (data) => data.trades.isNotEmpty
                ? _TradesList(trades: data.trades)
                : _EmptyList(user: user, isFiltered: data.isFilterd),
            error: (e, _) => UnknownError(error: e),
            loading: () => const Loader(),
          ),
        ),
      ),
    );
  }
}

class _AppBar extends ConsumerWidget implements PreferredSizeWidget {
  final Size size;
  final AppUserDetails? user;

  const _AppBar({required this.size, required this.user});

  void showFilterSheet(BuildContext context) => showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => FilterTradesSheet(user: user),
  );

  void showSortSheet(BuildContext context) => showModalBottomSheet(
    context: context,
    builder: (context) => const SortTradesSheet(),
  );

  void reset(WidgetRef ref) {
    ref.read(filterTradesProvider.notifier).state = .initial();
    ref.read(filterTradesOnSheetProvider.notifier).state = .initial();
  }

  bool get userIsNull => user == null;

  void export(WidgetRef ref, List<Trade> trades) =>
      ref.read(exportServiceProvider).exportTrades(trades);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    return AppBar(
      automaticallyImplyLeading: !userIsNull,
      title: Text(s.history),
      leading: userIsNull
          ? ref.watchWhenData(
              tradesProvider(user),
              builder: (data) => IconButton(
                onPressed: () => export(ref, data.trades),
                icon: const Icon(Icons.share),
              ),
            )
          : null,
      actions: [
        if (!userIsNull)
          ref.watchWhenData(
            tradesProvider(user),
            builder: (data) => IconButton(
              onPressed: () => export(ref, data.trades),
              icon: const Icon(Icons.share),
            ),
          ),
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
        userIsNull ? const SettingsButton() : const SizedBox.shrink(),
      ],
    );
  }

  @override
  Size get preferredSize => size;
}

class _TradesList extends StatelessWidget {
  final List<Trade> trades;

  const _TradesList({required this.trades});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: trades.length,
      itemBuilder: (context, index) {
        final trade = trades[index];
        return TradeCard(trade: trade);
      },
    );
  }
}

class _EmptyList extends ConsumerWidget {
  final AppUserDetails? user;
  final bool isFiltered;

  const _EmptyList({required this.user, required this.isFiltered});

  void reset(WidgetRef ref) {
    ref.read(filterTradesProvider.notifier).state = .initial();
    ref.read(filterTradesOnSheetProvider.notifier).state = .initial();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final s = S.of(context);
    return Column(
      mainAxisAlignment: .center,
      children: [
        Text(
          isFiltered ? s.no_operations_found : s.empty_trades(user != null),
          style: theme.textTheme.displayLarge,
        ),
        isFiltered
            ? TextButton(onPressed: () => reset(ref), child: Text(s.reset))
            : user == null
            ? TextButton(
                onPressed: () => AutoTabsRouter.of(context).setActiveIndex(0),
                child: Text(s.perform),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}

enum PopupMenuType { filter, sort, reset }
