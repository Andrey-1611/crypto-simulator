import 'package:Bitmark/app/widgets/size_box.dart';
import 'package:Bitmark/core/utils/extensions.dart';
import 'package:flutter/material.dart';

import 'loader.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.s;
    return AlertDialog(
      title: Column(
        children: [
          const Loader(),
          const SizeBox(height: 0.02),
          Text(s.loading),
        ],
      ),
    );
  }
}
