import 'package:Bitmark/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:Bitmark/core/utils/toast_helper.dart';
import 'package:Bitmark/data/models/trade.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/widgets/info_card.dart';
import '../../../app/widgets/size_box.dart';
import '../../../core/utils/dialog_helper.dart';
import '../../../core/utils/extensions.dart';
import '../../../data/models/coin_amount.dart';
import '../../../data/models/crypto_coin.dart';
import '../../briefcase/providers/briefcase_provider.dart';
import 'coins_text_field.dart';

class SellCryptoCoinSheet extends ConsumerStatefulWidget {
  final CryptoCoin coin;
  final double coinPrice;
  final int? amount;

  const SellCryptoCoinSheet({
    super.key,
    required this.coin,
    required this.coinPrice,
    this.amount,
  });

  @override
  ConsumerState createState() => _BuyCryptoCoinSheetState();
}

class _BuyCryptoCoinSheetState extends ConsumerState<SellCryptoCoinSheet> {
  final TextEditingController _coinsController = TextEditingController();

  double _totalPrice = 0;

  CryptoCoin get coin => widget.coin;

  double get coinPrice => widget.coinPrice;

  late int coinsAmount;

  @override
  void initState() {
    super.initState();
    _coinsController.addListener(() {
      coinsAmount = int.tryParse(_coinsController.text) ?? 0;
      setState(() {
        _totalPrice = coinsAmount * coinPrice;
      });
    });
    if (widget.amount != null) {
      _coinsController.text = widget.amount.toString();
    }
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

  Future<void> sell(BuildContext context, int userCoinsAmount) async {
    if (coinsAmount <= userCoinsAmount) {
      await ref
          .read(briefcaseNotifierProvider(null).notifier)
          .createTrade(coin: coin, amount: coinsAmount, type: TradeType.sell);
    } else {
      ToastHelper.coinsAmountError();
    }
  }

  void addAll(int amount) => _coinsController.text = amount.toString();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final size = MediaQuery.of(context);
    final s = S.of(context);
    return Padding(
      padding: .only(
        top: 32.sp,
        left: 32.sp,
        right: 32.sp,
        bottom: size.viewInsets.bottom + 32.sp,
      ),
      child: ref.watchWhen(
        briefcaseNotifierProvider(null),
        builder: (data) {
          final user = data.user;
          final userCoinsAmount = user.coins
              .firstWhere(
                (c) => c.coin.symbol == coin.symbol,
                orElse: () => CoinAmount.empty(),
              )
              .amount;
          return Column(
            mainAxisAlignment: .center,
            mainAxisSize: .min,
            children: [
              Text(
                s.sell_coin_a(coin.name),
                style: theme.textTheme.displayMedium,
              ),
              const SizeBox(height: 0.06),
              CoinsTextField(
                coinsController: _coinsController,
                addAll: () => addAll(userCoinsAmount),
              ),
              const SizeBox(height: 0.01),
              InfoCard(
                title: s.coins_balance,
                value: userCoinsAmount.toString(),
              ),
              InfoCard(title: s.balance, value: user.balance.price4),
              InfoCard(title: s.trade, value: _totalPrice.price4),
              ElevatedButton(
                onPressed: () =>
                    _totalPrice != 0 ? sell(context, userCoinsAmount) : null,
                child: Text(s.confirm),
              ),
              const SizeBox(height: 0.08),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _coinsController.dispose();
    super.dispose();
  }
}
