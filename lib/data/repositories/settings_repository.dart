import 'dart:async';
import 'package:crypto_simulator/app/runner/app_dependencies.dart';
import 'package:crypto_simulator/data/data_sources/settings_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsRepositoryProvider = FutureProvider<SettingsRepository>((ref) async {
  return SettingsDataSource(preferences: await ref.read(prefsProvider.future));
});

abstract interface class SettingsRepository {
  bool get theme;

  bool get language;

  Future<void> setTheme(bool theme);

  Future<void> setLanguage(bool language);
}
