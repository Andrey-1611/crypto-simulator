import 'package:auto_route/auto_route.dart';
import 'package:crypto_simulator/app/widgets/loader.dart';
import 'package:crypto_simulator/app/widgets/unknown_error.dart';
import 'package:crypto_simulator/core/utils/toast_helper.dart';
import 'package:crypto_simulator/data/models/trade.dart';
import 'package:crypto_simulator/features/market/widgets/coins_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/widgets/info_card.dart';
import '../../../core/utils/price_formatter.dart';
import '../../../data/models/crypto_coin_details.dart';
import '../../briefcase/providers/briefcase_provider.dart';

class BuyCryptoCoinSheet extends ConsumerStatefulWidget {
  final CryptoCoinDetails coin;

  const BuyCryptoCoinSheet({super.key, required this.coin});

  @override
  ConsumerState createState() => _BuyCryptoCoinSheetState();
}

class _BuyCryptoCoinSheetState extends ConsumerState<BuyCryptoCoinSheet> {
  final TextEditingController _coinsController = TextEditingController();

  double _totalPrice = 0;

  CryptoCoinDetails get coin => widget.coin;

  @override
  void initState() {
    super.initState();
    _coinsController.addListener(() {
      final coins = int.tryParse(_coinsController.text) ?? 0;
      setState(() {
        _totalPrice = coins * coin.currentPrice;
      });
    });
  }

  Future<void> createTrade(BuildContext context, double balance) async {
    if (_totalPrice <= balance) {
      await ref
          .read(briefcaseNotifierProvider.notifier)
          .createTrade(
            coin: coin.info,
            coinPrice: coin.currentPrice,
            amount: int.tryParse(_coinsController.text) ?? 0,
            type: TradeType.buy,
          );
      ToastHelper.success(Theme.of(context));
      if (mounted) context.pop();
    } else {
      ToastHelper.balanceError(Theme.of(context));
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
        data: (user) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Покупка ${coin.name}', style: theme.textTheme.displayMedium),
            const Spacer(),
            CoinsTextField(coinsController: _coinsController),
            InfoCard(title: 'Баланс', value: user!.balance.price),
            InfoCard(title: 'Сделка', value: _totalPrice.price),
            ElevatedButton(
              onPressed: () =>
                  _totalPrice != 0 ? createTrade(context, user.balance) : null,
              child: const Text('Подтвердить'),
            ),
            const Spacer(),
          ],
        ),
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
