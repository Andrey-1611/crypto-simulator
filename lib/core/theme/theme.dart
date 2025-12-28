import 'package:flutter/material.dart';

const _primaryColor = Color(0xFF0D6EFD);
const _cardColor = Color(0xFF1E1E1E);

class AppTheme {
  static final darkTheme = ThemeData(
    primaryColor: _primaryColor,
    textTheme: _textTheme,
    appBarTheme: _appBarTheme,
    bottomNavigationBarTheme: _bottomNavigationBarTheme,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColor,
      brightness: Brightness.dark,
    ),
  );
}

final _textTheme = const TextTheme(
  displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.w400),
  displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.w400),
  displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.w400),

  headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
  headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
  headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),

  titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
  titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
  titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),

  labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
  labelMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),

  bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
  bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
  bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
);

final _appBarTheme = const AppBarThemeData(
  centerTitle: true,
  backgroundColor: _cardColor,
  titleTextStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 32),
);

final _bottomNavigationBarTheme = const BottomNavigationBarThemeData(
  showUnselectedLabels: false,
  backgroundColor: _cardColor,
);
