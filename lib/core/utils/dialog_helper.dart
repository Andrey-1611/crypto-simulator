import 'package:auto_route/auto_route.dart';
import 'package:crypto_simulator/app/widgets/loader.dart';
import 'package:crypto_simulator/app/widgets/size_box.dart';
import 'package:flutter/material.dart';

abstract class DialogHelper {
  static void loading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        title: Column(
          children: [Loader(), SizeBox(height: 0.02), Text('Загрузка...')],
        ),
      ),
    );
  }

  static void signOut(BuildContext context, VoidCallback signOut) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Вы уверены, что хотите выйти из акканта?'),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Отмена'),
          ),
          TextButton(onPressed: signOut, child: const Text('Подтвердить')),
        ],
      ),
    );
  }
}
