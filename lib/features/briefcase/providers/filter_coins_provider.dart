import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

final filterCoinsProvider = StateProvider<FilterCoinsState>((_) => .initial());

final filterCoinsOnSheetProvider = StateProvider<FilterCoinsState>(
  (_) => .initial(),
);

class FilterCoinsState {
  final String coinName;

  final RangeValues? priceRange;

  final RangeValues? totalPriceRange;

  final RangeValues? amountRange;

  const FilterCoinsState({
    this.coinName = '',
    this.priceRange,
    this.totalPriceRange,
    this.amountRange,
  });

  factory FilterCoinsState.initial() => const FilterCoinsState();

  FilterCoinsState copyWith({
    String? coinName,
    RangeValues? priceRange,
    RangeValues? totalPriceRange,
    RangeValues? amountRange,
  }) {
    return FilterCoinsState(
      coinName: coinName ?? this.coinName,
      priceRange: priceRange ?? this.priceRange,
      totalPriceRange: totalPriceRange ?? this.totalPriceRange,
      amountRange: amountRange ?? this.amountRange,
    );
  }
}
