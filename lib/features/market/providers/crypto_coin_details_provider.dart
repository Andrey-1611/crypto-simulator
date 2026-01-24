import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/crypto_coin.dart';
import '../../../data/models/crypto_coin_details.dart';
import '../../../data/repositories/crypto_repository.dart';

final cryptoCoinDetailsProvider =
FutureProvider.autoDispose.family<CryptoCoinDetails, CryptoCoin>((ref, coin) async {
  if (coin is CryptoCoinDetails) return coin;
  return await ref.read(cryptoRepositoryProvider).getCoinBySimbol(coin);
});
