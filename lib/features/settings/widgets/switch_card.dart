import 'package:flutter/material.dart';

class SwitchCard extends StatelessWidget {
  final String title;
  final bool value;
  final VoidCallback onChanged;

  const SwitchCard({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: Switch(value: value, onChanged: (_) => onChanged()),
      ),
    );
  }
}
