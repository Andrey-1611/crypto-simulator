import 'package:Bitmark/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CoinsTextField extends StatelessWidget {
  final TextEditingController coinsController;

  const CoinsTextField({super.key, required this.coinsController});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return TextField(
      controller: coinsController,
      autofocus: true,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(hintText: s.num_coins),
    );
  }
}
