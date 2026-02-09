import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/databases_constants.dart';
import '../repositories/settings_repository.dart';

class SettingsDataSource implements SettingsRepository {
  final SharedPreferences _preferences;

  SettingsDataSource({required SharedPreferences preferences})
    : _preferences = preferences;

  @override
  bool get theme => _preferences.getBool(DatabasesConstants.themeKey) ?? true;

  @override
  bool get language =>
      _preferences.getBool(DatabasesConstants.languageKey) ?? false;

  @override
  Future<void> setLanguage(bool language) async {
    await _preferences.setBool(DatabasesConstants.languageKey, language);
  }

  @override
  Future<void> setTheme(bool theme) async {
    await _preferences.setBool(DatabasesConstants.themeKey, theme);
  }
}
