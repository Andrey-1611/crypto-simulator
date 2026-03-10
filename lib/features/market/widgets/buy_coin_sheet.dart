import 'package:Bitmark/app/widgets/size_box.dart';
import 'package:Bitmark/core/utils/extensions.dart';
import 'package:auto_route/auto_route.dart';
import 'package:Bitmark/app/widgets/loader.dart';
import 'package:Bitmark/app/widgets/unknown_error.dart';
import 'package:Bitmark/core/utils/toast_helper.dart';
import 'package:Bitmark/data/models/trade.dart';
import 'package:Bitmark/features/market/widgets/coins_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        _totalPrice = coins * coin.priceData.price;
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
        error: (_, _) {
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
            coinPrice: coin.priceData.price,
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
    final size = MediaQuery.of(context);
    return Padding(
      padding: .only(
        left: 32.sp,
        right: 32.sp,
        top: 32.sp,
        bottom: size.viewInsets.bottom + 32.sp,
      ),
      child: userP.when(
        data: (data) => Column(
          mainAxisAlignment: .center,
          mainAxisSize: .min,
          children: [
            Text(
              s.buy_coin(coin.info.name),
              style: theme.textTheme.displayMedium,
            ),
            const SizeBox(height: 0.06),
            CoinsTextField(coinsController: _coinsController),
            const SizeBox(height: 0.01),
            InfoCard(title: s.balance, value: data.user.balance.price4),
            InfoCard(title: S.of(context).trade, value: _totalPrice.price4),
            ElevatedButton(
              onPressed: () => _totalPrice != 0
                  ? createTrade(context, data.user.balance)
                  : null,
              child: Text(s.confirm),
            ),
            const SizeBox(height: 0.06),
          ],
        ),
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
