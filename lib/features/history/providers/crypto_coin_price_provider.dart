import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories/crypto_repository.dart';

final cryptoCoinPriceProvider = FutureProvider.autoDispose
    .family<double, String>((ref, symbol) async {
      return await ref
          .read(cryptoRepositoryProvider)
          .getCoinPriceBySymbol(symbol);
    });
