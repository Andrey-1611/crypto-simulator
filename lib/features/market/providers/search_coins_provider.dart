import 'package:Bitmark/data/models/coin_price.dart';
import 'package:Bitmark/data/repositories/crypto_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final searchCoinProvider = FutureProvider<List<CoinPrice>>((ref) async {
  final query = ref.watch(queryProvider);
  if (query.isEmpty) return [];
  return await ref.read(cryptoRepositoryProvider).searchCoins(query);
});

final queryProvider = StateProvider<String>((_) => '');
