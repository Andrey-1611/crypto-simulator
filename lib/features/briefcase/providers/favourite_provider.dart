import 'dart:async';
import 'package:Bitmark/data/models/crypto_coin.dart';
import 'package:Bitmark/data/repositories/local_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/coin_price.dart';
import '../../../data/repositories/crypto_repository.dart';

final favouriteNotifierProvider = AsyncNotifierProvider(FavouriteNotifier.new);

class FavouriteNotifier extends AsyncNotifier<List<CoinPrice>> {
  @override
  FutureOr<List<CoinPrice>> build() async {
    final coins = await ref.read(localRepositoryProvider).getFavouriteCoins();
    final coinsSymbols = coins.map((c) => c.symbol).toList();
    final coinsPrices = await ref
        .read(cryptoRepositoryProvider)
        .getCoinsPricesBySymbols(coinsSymbols);
    return coinsPrices.map((detail) {
      final coin = coins.firstWhere((c) => c.symbol == detail.symbol);
      return CoinPrice(coin: coin, price: detail.price);
    }).toList();
  }

  Future<void> toggleIsFavourite(CryptoCoin coin, double price) async {
    final coins = state.requireValue;
    final exist = coins.any((c) => c.coin.id == coin.id);
    state = await .guard(() async {
      if (exist) {
        await ref.read(localRepositoryProvider).removeFavouriteCoin(coin.id);
        return coins.where((c) => c.coin.id != coin.id).toList();
      } else {
        await ref.read(localRepositoryProvider).addFavouriteCoin(coin);
        final newCoin = CoinPrice(coin: coin, price: price);
        return [newCoin, ...coins];
      }
    });
  }
}
