import 'package:Bitmark/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CoinsTextField extends StatelessWidget {
  final TextEditingController coinsController;
  final bool autofocus;
  final void Function(String)? onChanged;
  final int? maxLength;

  const CoinsTextField({
    super.key,
    required this.coinsController,
    this.autofocus = true,
    this.onChanged,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return TextField(
      controller: coinsController,
      autofocus: autofocus,
      keyboardType: .number,
      onChanged: onChanged,
      maxLength: maxLength,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(hintText: s.num_coins, counterText: ''),
    );
  }
}
