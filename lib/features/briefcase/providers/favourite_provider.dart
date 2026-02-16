import 'dart:async';
import 'package:Bitmark/data/models/crypto_coin.dart';
import 'package:Bitmark/data/repositories/local_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories/crypto_repository.dart';

final favouriteNotifierProvider = AsyncNotifierProvider(FavouriteNotifier.new);

class FavouriteNotifier extends AsyncNotifier<List<CryptoCoinPrice>> {
  @override
  FutureOr<List<CryptoCoinPrice>> build() async {
    final coins = await ref.read(localRepositoryProvider).getFavouriteCoins();
    final coinsSymbols = coins.map((c) => c.symbol).toList();
    final coinsPrices = await ref
        .read(cryptoRepositoryProvider)
        .getCoinsPricesBySymbols(coinsSymbols);
    return coinsPrices.map((detail) {
      final coin = coins.firstWhere((c) => c.symbol == detail.symbol);
      return CryptoCoinPrice(coin: coin, price: detail.price);
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
        final newCoin = CryptoCoinPrice(coin: coin, price: price);
        return [newCoin, ...coins];
      }
    });
  }
}

class CryptoCoinPrice {
  final CryptoCoin coin;
  final double price;

  CryptoCoinPrice({required this.coin, required this.price});

  CryptoCoinPrice copyWith({CryptoCoin? coin, double? price}) {
    return CryptoCoinPrice(coin: coin ?? this.coin, price: price ?? this.price);
  }
}
