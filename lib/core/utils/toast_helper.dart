import 'package:fluttertoast/fluttertoast.dart';
import '../../generated/l10n.dart';

class ToastHelper {
   static final s = S.current;

  static void _toast(String msg) {
    Fluttertoast.showToast(msg: msg);
  }

  static void unknownError() {
    _toast(s.unknown_error);
  }

  static void success() {
    _toast(s.success);
  }

  static void balanceError() {
    _toast(s.balance_error);
  }

  static void coinsAmountError() {
    _toast(s.coins_amount_error);
  }
}
