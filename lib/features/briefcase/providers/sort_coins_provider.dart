import 'package:flutter_riverpod/legacy.dart';

final sortCoinsProvider = StateProvider<CoinSortType>((_) => .highTotal);

enum CoinSortType {
  moreCoins,
  lessCoins,
  highPrice,
  lowPrice,
  highTotal,
  lowTotal,
}
