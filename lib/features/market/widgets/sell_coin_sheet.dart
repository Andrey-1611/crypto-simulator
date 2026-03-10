import 'package:Bitmark/data/models/crypto_coin_details.dart';
import 'package:Bitmark/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:Bitmark/app/widgets/loader.dart';
import 'package:Bitmark/app/widgets/unknown_error.dart';
import 'package:Bitmark/core/utils/toast_helper.dart';
import 'package:Bitmark/data/models/trade.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/widgets/info_card.dart';
import '../../../app/widgets/size_box.dart';
import '../../../core/utils/dialog_helper.dart';
import '../../../core/utils/extensions.dart';
import '../../../data/models/coin_amount.dart';
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
        _totalPrice = coinsAmount * coin.priceData.price;
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

  Future<void> sell(BuildContext context, int userCoinsAmount) async {
    if (coinsAmount <= userCoinsAmount) {
      await ref
          .read(briefcaseNotifierProvider(null).notifier)
          .createTrade(
            coin: coin.info,
            coinPrice: coin.priceData.price,
            amount: coinsAmount,
            type: TradeType.sell,
          );
    } else {
      ToastHelper.coinsAmountError();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final userP = ref.watch(briefcaseNotifierProvider(null));
    final size = MediaQuery.of(context);
    final s = S.of(context);
    return Padding(
      padding: .only(
        top: 32.sp,
        left: 32.sp,
        right: 32.sp,
        bottom: size.viewInsets.bottom + 32.sp,
      ),
      child: userP.when(
        data: (data) {
          final user = data.user;
          final userCoinsAmount = user.coins
              .firstWhere(
                (c) => c.coin.symbol == coin.info.symbol,
                orElse: () => CoinAmount.empty(),
              )
              .amount;
          return Column(
            mainAxisAlignment: .center,
            mainAxisSize: .min,
            children: [
              Text(
                s.sell_coin_a(coin.info.name),
                style: theme.textTheme.displayMedium,
              ),
              const SizeBox(height: 0.06),
              CoinsTextField(coinsController: _coinsController),
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
        error: (e, _) => UnknownError(error: e),
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
