import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastHelper {
  static void _showToast(String msg, ThemeData theme) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: theme.hintColor,
      textColor: theme.cardColor,
    );
  }

  static void unknownError(ThemeData theme) {
    _showToast('Неизвестная ошибка, попробуйте похже', theme);
  }

  static void success(ThemeData theme) {
    _showToast('Успешно!', theme);
  }

  static void balanceError(ThemeData theme) {
    _showToast('На балансе недостаточно средств!', theme);
  }

  static void coinsAmountError(ThemeData theme) {
    _showToast('У вас нет необходимого количества монет!', theme);
  }
}
