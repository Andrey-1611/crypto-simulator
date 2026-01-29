import 'package:crypto_simulator/core/constants/databases_constants.dart';
import 'package:crypto_simulator/data/repositories/settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsDataSource implements SettingsRepository {
  final SharedPreferences _preferences;

  SettingsDataSource({required SharedPreferences preferences})
    : _preferences = preferences;

  @override
  bool get theme => _preferences.getBool(DatabasesConstants.themeKey) ?? true;

  @override
  bool get language => _preferences.getBool(DatabasesConstants.languageKey) ?? true;

  @override
  Future<void> setLanguage(bool language) async {
    await _preferences.setBool(DatabasesConstants.languageKey, language);
  }

  @override
  Future<void> setTheme(bool theme) async {
    await _preferences.setBool(DatabasesConstants.themeKey, theme);
  }
}
