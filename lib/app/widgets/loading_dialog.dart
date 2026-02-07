import 'package:Bitmark/app/widgets/size_box.dart';
import 'package:flutter/material.dart';

import 'loader.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Column(
        children: [Loader(), SizeBox(height: 0.02), Text('Загрузка...')],
      ),
    );
  }
}
