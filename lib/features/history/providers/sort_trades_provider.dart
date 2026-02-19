import 'package:flutter_riverpod/legacy.dart';

final sortTradesProvider = StateProvider<TradeSortType>((_) => .newestFirst);

enum TradeSortType {
  newestFirst,
  oldestFirst,
  highestTotal,
  lowestTotal,
  highestAmount,
  lowestAmount,
}
