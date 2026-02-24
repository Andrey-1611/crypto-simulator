import 'package:Bitmark/data/models/coin_price.dart';
import 'package:Bitmark/features/market/providers/filter_providers.dart';
import 'package:Bitmark/features/market/providers/market_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final filteredCoinsProvider = FutureProvider<List<CoinPrice>>((ref) async {
  final coins = await ref.watch(marketNotifierProvider.future);
  final search = ref.watch(searchCoinsProvider);
  return coins
      .where(
        (c) =>
            c.coin.name.toLowerCase().contains(search.toLowerCase()) ||
            c.coin.symbol.toLowerCase().contains(search.toLowerCase()),
      )
      .toList();
});
