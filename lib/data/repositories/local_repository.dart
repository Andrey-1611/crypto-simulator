import 'package:Bitmark/data/data_sources/local_data_source.dart';
import 'package:Bitmark/data/models/crypto_coin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localRepositoryProvider = Provider<LocalRepository>((ref) => LocalDataSource());

abstract interface class LocalRepository {
  Future<void> addFavouriteCoin(CryptoCoin coin);

  Future<void> removeFavouriteCoin(String coinId);

  Future<List<CryptoCoin>> getFavouriteCoins();
}
