import 'dart:async';
import 'package:Bitmark/app/runner/app_dependencies.dart';
import 'package:Bitmark/app/runner/app_initializer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';

void main() {
  final container = ProviderContainer();
  runZonedGuarded(() async {
    await AppInitializer.init(container);
    //await FirebaseAuth.instance.signOut();
    runApp(UncontrolledProviderScope(container: container, child: const App()));
  }, (e, st) => container.read(talkerProvider).handle(e, st));
}
