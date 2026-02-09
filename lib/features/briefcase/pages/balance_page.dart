import 'package:Bitmark/app/widgets/size_box.dart';
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
import '../providers/crypto_balance_provider.dart';
import '../providers/trades_provider.dart';

class BalancePage extends ConsumerWidget {
  final AppUserDetails? user;

  const BalancePage({super.key, this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userP = ref.watch(briefcaseNotifierProvider(user));
    final tradesP = ref.watch(tradesProvider(user?.id));
    final coinsPriceP = ref.watch(cryptoBalanceProvider(user));
    final s = S.of(context);
    return userP.when(
      data: (user) => ListView(
        children: [
          InfoBloc(
            title: s.balance_info,
            children: [
              InfoRow(title: s.balance, value: user.balance.price4),
              SizeBox(
                height: 0.087,
                child: coinsPriceP.when(
                  data: (price) => Column(
                    children: [
                      InfoRow(title: s.coin_balance, value: price.price4),
                      InfoRow(
                        title: s.total_balance,
                        value: (user.balance + price).price4,
                      ),
                    ],
                  ),
                  error: (_, _) => const _EmptyBalance(),
                  loading: () => const _EmptyBalance(),
                ),
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

class _EmptyBalance extends StatelessWidget {
  const _EmptyBalance();

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Column(
      children: [
        InfoRow(title: s.coin_balance, value: 1000.0000.price4),
        InfoRow(
          title: s.total_balance,
          value: 1000.0000.price4,
        ),
      ],
    );
  }
}

