import 'dart:async';
import 'package:Bitmark/app/runner/app_dependencies.dart';
import 'package:Bitmark/app/runner/app_initializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger_observer.dart';
import 'app/app.dart';

void main() {
  final container = ProviderContainer();
  runZonedGuarded(() async {
    await AppInitializer.init(container);
    runApp(
      ProviderScope(
        observers: [
          TalkerRiverpodObserver(talker: container.read(talkerProvider)),
        ],
        child: const App(),
      ),
    );
  }, (e, st) => container.read(talkerProvider).handle(e, st));
}
