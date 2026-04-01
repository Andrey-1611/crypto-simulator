import 'package:Bitmark/app/widgets/loading_dialog.dart';
import 'package:Bitmark/app/widgets/sign_out_dialog.dart';
import 'package:Bitmark/data/models/crypto_coin.dart';
import 'package:flutter/material.dart';

import '../../features/market/widgets/buy_coin_sheet.dart';
import '../../features/market/widgets/sell_coin_sheet.dart';

abstract class DialogHelper {
  static void loading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const LoadingDialog(),
    );
  }

  static void signOut(BuildContext context, VoidCallback signOut) {
    showDialog(
      context: context,
      builder: (context) => SignOutDialog(signOut: signOut),
    );
  }

  static void buyCoin({
    required BuildContext context,
    required CryptoCoin coin,
    required double coinPrice,
    int? amount,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) =>
          BuyCryptoCoinSheet(coin: coin, coinPrice: coinPrice, amount: amount),
    );
  }

  static void sellCoin({
    required BuildContext context,
    required CryptoCoin coin,
    required double coinPrice,
    int? amount,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) =>
          SellCryptoCoinSheet(coin: coin, coinPrice: coinPrice, amount: amount),
    );
  }
}
