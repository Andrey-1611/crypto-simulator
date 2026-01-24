extension PriceFormatter on double {
  String get price => '${toStringAsFixed(4)} \$';

  String get percent => '${toStringAsFixed(2)} %';
}
