import 'package:Bitmark/app/widgets/loading_dialog.dart';
import 'package:Bitmark/app/widgets/sign_out_dialog.dart';
import 'package:flutter/material.dart';

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
}
