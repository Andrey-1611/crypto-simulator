import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CoinsTextField extends StatelessWidget {
  final TextEditingController coinsController;

  const CoinsTextField({super.key, required this.coinsController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: coinsController,
      autofocus: true,
      maxLength: 5,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: const InputDecoration(hintText: 'Количество монет'),
    );
  }
}
