import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../router/app_router.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.pushRoute(const SettingsRoute()),
      icon: const Icon(Icons.settings),
    );
  }
}
