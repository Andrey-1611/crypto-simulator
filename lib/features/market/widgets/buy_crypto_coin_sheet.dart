import 'package:Bitmark/core/utils/extensions.dart';
import 'package:auto_route/auto_route.dart';
import 'package:Bitmark/app/widgets/loader.dart';
import 'package:Bitmark/app/widgets/unknown_error.dart';
import 'package:Bitmark/core/utils/toast_helper.dart';
import 'package:Bitmark/data/models/trade.dart';
import 'package:Bitmark/features/market/widgets/coins_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/widgets/info_card.dart';
import '../../../core/utils/dialog_helper.dart';
import '../../../data/models/crypto_coin_details.dart';
import '../../../generated/l10n.dart';
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
    ref.listenManual(briefcaseNotifierProvider(null), (_, state) {
      state.when(
        loading: () => DialogHelper.loading(context),
        data: (user) {
          ToastHelper.success();
          context.pop();
          context.pop();
        },
        error: (e, _) {
          context.pop();
          ToastHelper.unknownError();
        },
      );
    });
  }

  Future<void> createTrade(BuildContext context, double balance) async {
    if (_totalPrice <= balance) {
      await ref
          .read(briefcaseNotifierProvider(null).notifier)
          .createTrade(
            coin: coin.info,
            coinPrice: coin.currentPrice,
            amount: int.tryParse(_coinsController.text) ?? 0,
            type: TradeType.buy,
          );
    } else {
      ToastHelper.balanceError();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final userP = ref.watch(briefcaseNotifierProvider(null));
    final s = S.of(context);
    return Padding(
      padding: const .all(32),
      child: userP.when(
        data: (user) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(s.buy_coin(coin.name), style: theme.textTheme.displayMedium),
            const Spacer(),
            CoinsTextField(coinsController: _coinsController),
            InfoCard(title: s.balance, value: user.balance.price4),
            InfoCard(title: S.of(context).trade, value: _totalPrice.price4),
            ElevatedButton(
              onPressed: () =>
                  _totalPrice != 0 ? createTrade(context, user.balance) : null,
              child: Text(s.confirm),
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
