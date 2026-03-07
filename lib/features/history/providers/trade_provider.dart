import 'package:Bitmark/data/models/coin_price.dart';
import 'package:Bitmark/data/repositories/crypto_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/trade.dart';

final tradeProvider =
    FutureProvider.family<({Trade trade, CoinPrice coin}), Trade>((
      ref,
      trade,
    ) async {
      final price = await ref
          .read(cryptoRepositoryProvider)
          .getCoinPriceBySymbol(trade.coin.symbol);
      final coinPrice = CoinPrice(coin: trade.coin, price: price);
      return (trade: trade, coin: coinPrice);
    });
