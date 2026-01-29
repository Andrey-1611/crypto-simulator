import 'package:crypto_simulator/app/widgets/unknown_error.dart';
import 'package:crypto_simulator/core/utils/formatter.dart';
import 'package:crypto_simulator/data/models/app_user.dart';
import 'package:crypto_simulator/features/briefcase/providers/trades_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/widgets/info_bloc.dart';
import '../../../app/widgets/info_row.dart';
import '../../../app/widgets/loader.dart';
import '../../../data/models/trade.dart';
import '../../../generated/l10n.dart';
import '../providers/briefcase_provider.dart';
import '../providers/crypto_balance_provider.dart';

class BalancePage extends ConsumerWidget {
  final AppUser? user;

  const BalancePage({super.key, this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userP = ref.watch(briefcaseNotifierProvider(user));
    final tradesP = ref.watch(tradesProvider(user?.id));
    final coinsPriceP = ref.watch(cryptoBalanceProvider(user));
    final s = S.of(context);
    return userP.when(
      data: (user) => Column(
        children: [
          InfoBloc(
            title: s.balance_info,
            children: [
              InfoRow(title: s.balance, value: user.balance.price4),
              coinsPriceP.when(
                data: (price) => Column(
                  children: [
                    InfoRow(title: s.coin_balance, value: price.price4),
                    InfoRow(
                      title: s.total_balance,
                      value: (user.balance + price).price4,
                    ),
                  ],
                ),
                error: (_, _) => const SizedBox(),
                loading: () => const SizedBox(),
              ),
            ],
          ),
          tradesP.when(
            data: (trades) => Column(
              children: [
                InfoBloc(
                  title: s.transaction_info,
                  children: [
                    InfoRow(
                      title: s.num_transactions,
                      value: trades.length.toString(),
                    ),
                    InfoRow(
                      title: s.total_spent,
                      value: trades.tradesTotalPrice.price4,
                    ),
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
                      title: s.num_coins_purchased,
                      value: trades.boughtCoinsLength.toString(),
                    ),
                    InfoRow(
                      title: s.num_coins,
                      value: user.allCoinsLength.toString(),
                    ),
                  ],
                ),
              ],
            ),
            error: (_, _) => const UnknownError(),
            loading: () => const Loader(),
          ),
        ],
      ),
      error: (_, _) => UnknownError(
        onPressed: () =>
            ref.read(briefcaseNotifierProvider(user).notifier).build(),
      ),
      loading: () => const Loader(),
    );
  }
}
