import 'dart:async';
import 'package:crypto_simulator/app/runner/app_dependencies.dart';
import 'package:crypto_simulator/app/runner/app_initializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';

void main() {
  final container = ProviderContainer();
  runZonedGuarded(() async {
    await AppInitializer.init(container);
    runApp(const App());
  }, (e, st) => container.read(talkerProvider).handle(e, st));
}
