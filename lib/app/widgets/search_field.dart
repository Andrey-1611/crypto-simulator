import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback reset;
  final void Function(String)? onChanged;

  const SearchField({
    super.key,
    required this.controller,
    required this.reset,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);
    return TextField(
      controller: controller,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: s.search_hint,
        filled: true,
        fillColor: theme.scaffoldBackgroundColor,
        suffixIcon: IconButton(onPressed: reset, icon: const Icon(Icons.close)),
      ),
    );
  }
}
