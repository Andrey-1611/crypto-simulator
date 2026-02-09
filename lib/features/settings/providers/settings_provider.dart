import 'dart:async';
import 'package:Bitmark/data/repositories/settings_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsNotifierProvider = AsyncNotifierProvider(SettingsNotifier.new);

class SettingsNotifier extends AsyncNotifier<Settings> {
  @override
  FutureOr<Settings> build() async {
    final settings = await ref.read(settingsRepositoryProvider.future);
    return Settings(theme: settings.theme, language: settings.language);
  }

  Future<void> setTheme(bool theme) async {
    state = await AsyncValue.guard(() async {
      final settings = await ref.read(settingsRepositoryProvider.future);
      await settings.setTheme(theme);
      return Settings(theme: theme, language: settings.language);
    });
  }

  Future<void> setLanguage(bool language) async {
    state = await AsyncValue.guard(() async {
      final settings = await ref.read(settingsRepositoryProvider.future);
      await settings.setLanguage(language);
      return Settings(theme: settings.theme, language: settings.language);
    });
  }
}

class Settings {
  final bool theme;
  final bool language;

  Settings({required this.theme, required this.language});
}
