import 'package:crypto_simulator/core/utils/price_formatter.dart';
import 'package:crypto_simulator/data/models/crypto_coin_details.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:crypto_simulator/app/widgets/loader.dart';
import 'package:crypto_simulator/app/widgets/unknown_error.dart';
import 'package:crypto_simulator/core/utils/toast_helper.dart';
import 'package:crypto_simulator/data/models/trade.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/widgets/info_card.dart';
import '../../briefcase/providers/briefcase_provider.dart';
import 'coins_text_field.dart';

class SellCryptoCoinSheet extends ConsumerStatefulWidget {
  final CryptoCoinDetails coin;

  const SellCryptoCoinSheet({super.key, required this.coin});

  @override
  ConsumerState createState() => _BuyCryptoCoinSheetState();
}

class _BuyCryptoCoinSheetState extends ConsumerState<SellCryptoCoinSheet> {
  final TextEditingController _coinsController = TextEditingController();

  double _totalPrice = 0;

  CryptoCoinDetails get coin => widget.coin;

  late int coinsAmount;

  @override
  void initState() {
    super.initState();
    _coinsController.addListener(() {
      coinsAmount = int.tryParse(_coinsController.text) ?? 0;
      setState(() {
        _totalPrice = coinsAmount * coin.currentPrice;
      });
    });
  }

  Future<void> sell(BuildContext context, int userCoinsAmount) async {
    if (coinsAmount <= userCoinsAmount) {
      await ref
          .read(briefcaseNotifierProvider.notifier)
          .createTrade(
            coin: coin.info,
            coinPrice: coin.currentPrice,
            amount: coinsAmount,
            type: TradeType.sell,
          );
      ToastHelper.success(Theme.of(context));
      context.pop();
    } else {
      ToastHelper.coinsAmountError(Theme.of(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userP = ref.watch(briefcaseNotifierProvider);
    ref.listen(briefcaseNotifierProvider, (_, state) {
      if (state.hasError) ToastHelper.unknownError(theme);
    });
    return Padding(
      padding: const .all(32),
      child: userP.when(
        data: (user) {
          final userCoinsAmount = user!.coins
              .firstWhere(
                (c) => c.info.symbol == coin.symbol,
                orElse: () => (amount: 0, info: coin),
              )
              .amount;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Продажа ${coin.name}',
                style: theme.textTheme.displayMedium,
              ),
              const Spacer(),
              CoinsTextField(coinsController: _coinsController),
              InfoCard(
                title: 'Количество монет на балансе',
                value: userCoinsAmount.toString(),
              ),
              InfoCard(title: 'Баланс', value: user.balance.price),
              InfoCard(title: 'Сделка', value: _totalPrice.price),
              ElevatedButton(
                onPressed: () =>
                    _totalPrice != 0 ? sell(context, userCoinsAmount) : null,
                child: const Text('Подтвердить'),
              ),
              const Spacer(),
            ],
          );
        },
        error: (_, _) => UnknownError(onPressed: () {}),
        loading: () => const Loader(),
      ),
    );
  }

  @override
  void dispose() {
    _coinsController.dispose();
    super.dispose();
  }
}
