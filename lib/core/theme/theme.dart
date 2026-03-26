import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const _primary = Color(0xFF6366F1);
const _darkCard = Color(0xFF2A2A2A);

//const _splashColor = Color(0xFF0E1525);

const _hintColor = Color(0xFFB3B3B3);
const _lightBackground = Color(0xFFE8EAED);
const _darkBackground = Color(0xFF1E1E1E);

final darkTheme = ThemeData(
  useMaterial3: true,
  primaryColor: _primary,
  inputDecorationTheme: _inputDecorationTheme(_darkCard),
  appBarTheme: _appBarTheme(_darkCard, Colors.white),
  listTileTheme: _listTileTheme,
  cardTheme: _cardTheme(_darkCard),
  cardColor: _hintColor,
  textTheme: _textTheme,
  switchTheme: _switchTheme,
  navigationBarTheme: _navigationBarTheme(_darkCard, Colors.white),
  textButtonTheme: _textButtonTheme,
  elevatedButtonTheme: _elevatedButtonTheme,
  scaffoldBackgroundColor: _darkBackground,
  outlinedButtonTheme: _outlineButtonTheme,
  hintColor: _hintColor,
  dialogTheme: _dialogTheme,
  segmentedButtonTheme: _segmentedButtonTheme(Colors.white),
  colorScheme: const .dark(primary: _primary, error: Colors.red),
);

final lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: _primary,
  inputDecorationTheme: _inputDecorationTheme(Colors.white),
  appBarTheme: _appBarTheme(Colors.white, Colors.black),
  listTileTheme: _listTileTheme,
  cardTheme: _cardTheme(Colors.white),
  cardColor: _darkCard,
  outlinedButtonTheme: _outlineButtonTheme,
  textTheme: _textTheme,
  switchTheme: _switchTheme,
  navigationBarTheme: _navigationBarTheme(Colors.white, Colors.black),
  textButtonTheme: _textButtonTheme,
  elevatedButtonTheme: _elevatedButtonTheme,
  scaffoldBackgroundColor: _lightBackground,
  bottomSheetTheme: _bottomSheetTheme(_lightBackground),
  hintColor: _hintColor,
  dialogTheme: _dialogTheme,
  segmentedButtonTheme: _segmentedButtonTheme(Colors.black),
  colorScheme: const .light(primary: _primary, error: Colors.red),
);

final _textTheme = TextTheme(
  titleLarge: TextStyle(fontWeight: .bold, fontSize: 56.sp),
  titleMedium: TextStyle(fontWeight: .w800, fontSize: 42.sp),
  displayLarge: TextStyle(fontWeight: .bold, fontSize: 28.sp),
  displayMedium: TextStyle(fontWeight: .w800, fontSize: 20.sp),
  displaySmall: TextStyle(fontWeight: .w600, fontSize: 16.sp),
  bodyLarge: TextStyle(fontWeight: .w600, fontSize: 15.sp),
  bodyMedium: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 15.sp,
    color: _hintColor,
  ),
  bodySmall: TextStyle(fontWeight: .w400, fontSize: 14.sp, color: _hintColor),
  labelLarge: TextStyle(fontWeight: .w500, fontSize: 13.sp),
);

InputDecorationTheme _inputDecorationTheme(Color color) => InputDecorationTheme(
  filled: true,
  fillColor: color,
  hintStyle: TextStyle(fontSize: 15.sp, color: _hintColor),
  contentPadding: .all(12.sp),
  border: OutlineInputBorder(borderSide: .none, borderRadius: .circular(8.sp)),
);

final _listTileTheme = ListTileThemeData(
  contentPadding: .symmetric(vertical: 4.sp, horizontal: 8.sp),
  subtitleTextStyle: TextStyle(
    fontWeight: .w400,
    fontSize: 14.sp,
    color: _hintColor,
  ),
);

CardThemeData _cardTheme(Color color) => CardThemeData(
  color: color,
  margin: .all(8.sp),
  shape: RoundedRectangleBorder(
    borderRadius: .circular(8.sp),
    side: BorderSide.none,
  ),
);

AppBarTheme _appBarTheme(Color color, Color titleColor) => AppBarTheme(
  centerTitle: true,
  backgroundColor: color,
  titleTextStyle: TextStyle(
    fontSize: 26.sp,
    fontWeight: .bold,
    color: titleColor,
  ),
  surfaceTintColor: Colors.transparent,
);

NavigationBarThemeData _navigationBarTheme(Color color, Color iconColor) =>
    NavigationBarThemeData(
      backgroundColor: color,
      indicatorColor: _primary,
      iconTheme: .all(IconThemeData(color: iconColor)),
    );

final _textButtonTheme = TextButtonThemeData(
  style: TextButton.styleFrom(
    textStyle: TextStyle(fontWeight: .w600, fontSize: 16.sp),
    foregroundColor: _primary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
);

final _elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: _primary,
    textStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 20.sp,
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0.sp)),
  ),
);

final _outlineButtonTheme = OutlinedButtonThemeData(
  style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0.sp)),
  ),
);

final _switchTheme = SwitchThemeData(
  thumbColor: WidgetStateProperty.resolveWith((states) {
    return states.contains(WidgetState.selected) ? Colors.white : _primary;
  }),
);

BottomSheetThemeData _bottomSheetTheme(Color color) =>
    BottomSheetThemeData(backgroundColor: color);

final _dialogTheme = DialogThemeData(
  titleTextStyle: TextStyle(fontWeight: .w600, fontSize: 18.sp),
);

SegmentedButtonThemeData _segmentedButtonTheme(Color textColor) =>
    SegmentedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: .all(textColor),
        side: .all(.none),
        backgroundColor: .resolveWith(
          (states) =>
              states.contains(WidgetState.selected) ? _primary : _darkCard,
        ),
      ),
    );
