import 'package:crypto_simulator/app/widgets/unknown_error.dart';
import 'package:crypto_simulator/core/utils/price_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/widgets/info_bloc.dart';
import '../../../app/widgets/info_row.dart';
import '../../../app/widgets/loader.dart';
import '../providers/briefcase_provider.dart';
import '../providers/crypto_coins_balance_provider.dart';

class BalancePage extends ConsumerWidget {
  const BalancePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userP = ref.watch(briefcaseNotifierProvider);
    final coinsPriceP = ref.watch(cryptoCoinsBalanceProvider);
    return userP.when(
      data: (user) => Column(
        children: [
          InfoBloc(
            title: 'Данные о балансе',
            children: [
              InfoRow(title: 'Баланс', value: user!.balance.price),
              coinsPriceP.when(
                data: (price) => Column(
                  children: [
                    InfoRow(title: 'Баланс в монетах', value: price.price),
                    InfoRow(
                      title: 'Общий баланс',
                      value: (user.balance + price).price,
                    ),
                  ],
                ),
                error: (_, _) => const SizedBox(),
                loading: () => const SizedBox(),
              ),
            ],
          ),
          InfoBloc(
            title: 'Данных об операциях',
            children: [
              InfoRow(
                title: 'Количество операций',
                value: user.trades.length.toString(),
              ),
              InfoRow(
                title: 'Всего потрачено',
                value: user.tradesTotalPrice.price,
              ),
            ],
          ),
          InfoBloc(
            title: 'Данные о монетах',
            children: [
              InfoRow(
                title: 'Количество типов монет',
                value: user.coins.length.toString(),
              ),
              InfoRow(
                title: 'Количество купленых монет',
                value: user.boughtCoinsLength.toString(),
              ),
              InfoRow(
                title: 'Количество монет',
                value: user.allCoinsLength.toString(),
              ),
            ],
          ),
        ],
      ),
      error: (_, _) => UnknownError(
        onPressed: () => ref.read(briefcaseNotifierProvider.notifier).build(),
      ),
      loading: () => const Loader(),
    );
  }
}
