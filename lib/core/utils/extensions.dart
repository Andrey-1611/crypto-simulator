import 'dart:math';

import 'package:Bitmark/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringCheck on String? {
  bool get isNullOrEmpty => this == null || this!.trim().isEmpty;
}

extension EmailValidator on String {
  bool get isValidEmail =>
      RegExp(r"^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(this);
}

extension DateFormatter on DateTime {
  String get format => DateFormat('dd.MM.yyyy HH:mm').format(this);

  String get dayFormat => DateFormat('dd.MM.yyyy').format(this);
}

extension BoolToggle on bool {
  bool toggle() => !this;
}

extension StringCase on String {
  String get capitalize =>
      isEmpty ? this : this[0].toUpperCase() + substring(1).toLowerCase();
}

extension ContextX on BuildContext {
  ThemeData get theme => Theme.of(this);

  S get s => S.of(this);
}

extension PriceFormatter on double {
  String get price4 => '${toStringAsFixed(4)} \$';

  String get price2 => '${toStringAsFixed(2)} \$';

  String get price => '${toStringAsFixed(0)} \$';

  String get priceA {
    final value = switch (this) {
      >= 1000 => 0,
      >= 1 => 2,
      >= 0.01 => 4,
      >= 0.0001 => 6,
      _ => 8,
    };
    return '${toStringAsFixed(value)} \$';
  }

  String get percent {
    final sign = this > 0 ? '+' : '';
    return '$sign${toStringAsFixed(2)} %';
  }

  String get inPercent => '${toStringAsFixed(2)} %';

  String get toCryptoPrice {
    return switch (this) {
      >= 1e10 => '${(this / 1e9).toStringAsFixed(3)}B \$',
      >= 1e7 => '${(this / 1e6).toStringAsFixed(3)}M \$',
      >= 1e4 => '${(this / 1e3).toStringAsFixed(3)}K \$',
      _ => '${toStringAsFixed(2)} \$',
    };
  }
}

extension AmountFormatter on int {
  String get toCrypto {
    return switch (this) {
      >= 1e10 => '${(this / 1e9).toStringAsFixed(3)}B',
      >= 1e7 => '${(this / 1e6).toStringAsFixed(3)}M',
      >= 1e4 => '${(this / 1e3).toStringAsFixed(3)}K',
      _ => toStringAsFixed(2),
    };
  }
}

extension ChartFormat on double {
  String get toChart {
    final absValue = abs();
    double value = this;
    String suffix = '';
    if (absValue >= 1e9) {
      value = this / 1e9;
      suffix = 'B';
    } else if (absValue >= 1e6) {
      value = this / 1e6;
      suffix = 'M';
    } else if (absValue >= 1e3) {
      value = this / 1e3;
      suffix = 'K';
    }
    final absVal = value.abs();
    int integerDigits = absVal >= 1 ? absVal.floor().toString().length : 0;
    int decimals = 3 - integerDigits;
    if (decimals < 0) decimals = 0;
    final formatted = value.toStringAsFixed(decimals);
    return formatted + suffix;
  }
}

extension ColorRandom on Color {
  static Color random(int index) {
    final r = Random(index);
    return .fromARGB(255, r.nextInt(256), r.nextInt(256), r.nextInt(256));
  }
}
