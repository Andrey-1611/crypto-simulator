import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../data/models/trade.dart';

final filterTradesProvider = StateProvider((_) => const FilterTradesState());

final filterTradesOnSheetProvider = StateProvider(
  (_) => const FilterTradesState(),
);

class FilterTradesState {
  final String coinName;
  final TradeType tradeType;

  final DateTimeRange? dateRange;

  final RangeValues? totalPriceRange;

  final RangeValues? amountRange;

  const FilterTradesState({
    this.coinName = '',
    this.tradeType = .all,
    this.dateRange,
    this.totalPriceRange,
    this.amountRange,
  });

  FilterTradesState copyWith({
    String? coinName,
    TradeType? tradeType,
    DateTimeRange? dateRange,
    RangeValues? totalPriceRange,
    RangeValues? amountRange,
  }) {
    return FilterTradesState(
      coinName: coinName ?? this.coinName,
      tradeType: tradeType ?? this.tradeType,
      dateRange: dateRange ?? this.dateRange,
      totalPriceRange: totalPriceRange ?? this.totalPriceRange,
      amountRange: amountRange ?? this.amountRange,
    );
  }

  factory FilterTradesState.initial() => const FilterTradesState();

}
