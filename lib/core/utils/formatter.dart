import 'package:intl/intl.dart';

extension PriceFormatter on double {
  String get price4 => '${toStringAsFixed(4)} \$';

  String get price2 => '${toStringAsFixed(2)} \$';

  String get price => '${toStringAsFixed(0)} \$';

  String get percent => '${toStringAsFixed(2)} %';

  String get toCryptoPrice {
    return switch (this) {
      >= 1e10 => '${(this / 1e9).toStringAsFixed(2)}B \$',
      >= 1e7 => '${(this / 1e6).toStringAsFixed(2)}M \$',
      >= 1e4 => '${(this / 1e3).toStringAsFixed(2)}K \$',
      _ => '${toStringAsFixed(2)} \$',
    };
  }
}

extension AmountFormatter on int {
  String get toCrypto {
    return switch (this) {
      >= 1e10 => '${(this / 1e9).toStringAsFixed(2)}B',
      >= 1e7 => '${(this / 1e6).toStringAsFixed(2)}M',
      >= 1e4 => '${(this / 1e3).toStringAsFixed(2)}K',
      _ => '${toStringAsFixed(2)}',
    };
  }
}

extension DateFormatter on DateTime {
  String get date => DateFormat('dd.MM.yyyy HH:mm').format(this);
}
