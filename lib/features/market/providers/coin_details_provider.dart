import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/crypto_coin.dart';
import '../../../data/models/crypto_coin_details.dart';
import '../../../data/repositories/crypto_repository.dart';

final coinDetailsProvider = FutureProvider.autoDispose
    .family<CryptoCoinDetails, CryptoCoin>((ref, coin) async {
      return await ref.read(cryptoRepositoryProvider).getCoinDetailsBySymbol(coin);
    });
