import 'package:Bitmark/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CoinsTextField extends StatelessWidget {
  final TextEditingController coinsController;
  final VoidCallback addAll;

  const CoinsTextField({
    super.key,
    required this.coinsController,
    required this.addAll,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return TextField(
      controller: coinsController,
      keyboardType: .number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        hintText: s.num_coins,
        counterText: '',
        suffixIcon: IconButton(
          onPressed: addAll,
          icon: const Icon(Icons.expand_less),
        ),
      ),
    );
  }
}
