import 'package:Bitmark/core/utils/trades_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/widgets/info_bloc.dart';
import '../../../app/widgets/info_row.dart';
import '../../../app/widgets/loader.dart';
import '../../../app/widgets/unknown_error.dart';
import '../../../core/utils/extensions.dart';
import '../../../data/models/app_user_details.dart';
import '../../../data/models/trade.dart';
import '../../../generated/l10n.dart';
import '../providers/briefcase_provider.dart';

class BalancePage extends ConsumerWidget {
  final AppUserDetails? user;

  const BalancePage({super.key, this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userP = ref.watch(briefcaseNotifierProvider(user));
    final s = S.of(context);
    return userP.when(
      data: (data) {
        final user = data.user;
        final trades = data.trades;
        final balance = data.coinsBalance;
        final tradesUtils = TradesUtils(trades: trades);
        return ListView(
          children: [
            InfoBloc(
              title: s.balance_info,
              children: [
                InfoRow(title: s.balance, value: user.balance.price4),
                InfoRow(title: s.coin_balance, value: balance.price4),
                InfoRow(
                  title: s.total_balance,
                  value: (user.balance + balance).price4,
                ),
              ],
            ),
            InfoBloc(
              title: s.transaction_info,
              children: [
                InfoRow(title: s.avg_trade, value: tradesUtils.avgTrade.price4),
                InfoRow(
                  title: s.largest_trade,
                  value: tradesUtils.maxTrade.price4,
                ),
                InfoRow(
                  title: s.num_transactions,
                  value: tradesUtils.tradesLength.toString(),
                ),
                InfoRow(
                  title: s.first_trade,
                  value: tradesUtils.firstTrade?.hourFormat ?? '-',
                ),
                InfoRow(
                  title: s.last_trade,
                  value: tradesUtils.lastTrade?.hourFormat ?? '-',
                ),
                InfoRow(
                  title: s.total_spent,
                  value: trades.tradesTotalPrice.price4,
                ),
                InfoRow(
                  title: s.trades_7d,
                  value: tradesUtils.trades7d.toString(),
                ),
                InfoRow(title: s.spent_7d, value: tradesUtils.spent7d.price4),
                InfoRow(
                  title: s.trades_24h,
                  value: tradesUtils.trades24h.toString(),
                ),
                InfoRow(title: s.spent_24h, value: tradesUtils.spent24h.price4),
              ],
            ),
            InfoBloc(
              title: s.coin_info,
              children: [
                InfoRow(
                  title: s.num_coin_types,
                  value: user.coins.length.toString(),
                ),
                InfoRow(
                  title: s.num_coins,
                  value: user.allCoinsLength.toString(),
                ),
                InfoRow(
                  title: s.num_coins_purchased,
                  value: trades.boughtCoinsLength.toString(),
                ),
                InfoRow(
                  title: s.num_coins_purchased_7d,
                  value: tradesUtils.coins7d.toString(),
                ),
                InfoRow(
                  title: s.num_coins_purchased_24h,
                  value: tradesUtils.coins24h.toString(),
                ),
              ],
            ),
          ],
        );
      },
      error: (e, _) => UnknownError(
        onPressed: () =>
            ref.read(briefcaseNotifierProvider(user).notifier).build(),
        error: e,
      ),
      loading: () => const Loader(),
    );
  }
}
