import 'package:Bitmark/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CoinsTextField extends StatelessWidget {
  final TextEditingController coinsController;
  final bool autofocus;
  final void Function(String)? onChanged;

  const CoinsTextField({
    super.key,
    required this.coinsController,
    this.autofocus = true,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return TextField(
      controller: coinsController,
      autofocus: autofocus,
      keyboardType: .number,
      onChanged: onChanged,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(hintText: s.num_coins),
    );
  }
}
