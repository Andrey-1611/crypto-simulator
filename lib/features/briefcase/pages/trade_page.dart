import 'package:auto_route/annotations.dart';
import 'package:crypto_simulator/app/widgets/crypto_coin_card.dart';
import 'package:crypto_simulator/app/widgets/info_row.dart';
import 'package:crypto_simulator/app/widgets/loader.dart';
import 'package:crypto_simulator/app/widgets/unknown_error.dart';
import 'package:crypto_simulator/core/utils/price_formatter.dart';
import 'package:crypto_simulator/data/models/trade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/crypto_coin_price_provider.dart';

@RoutePage()
class TradePage extends ConsumerWidget {
  final Trade trade;

  const TradePage({super.key, required this.trade});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    final coinP = ref.watch(cryptoCoinPriceProvider(trade.coin.symbol));
    return Scaffold(
      appBar: AppBar(title: const Text('Детали сделаки')),
      body: Padding(
        padding: const .all(16),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.11,
                child: coinP.when(
                  data: (price) =>
                      CryptoCoinCard(coin: trade.coin, price: price),
                  error: (_, _) => const UnknownError(),
                  loading: () => const Loader(),
                ),
              ),
              Card(
                child: Padding(
                  padding: const .all(16),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text('Данные', style: theme.textTheme.bodyLarge),
                      SizedBox(height: size.height * 0.02),
                      InfoRow(title: 'Тип', value: trade.type.type),
                      InfoRow(
                        title: 'Количество',
                        value: trade.amount.toString(),
                      ),
                      InfoRow(title: 'Монета', value: trade.coin.symbol),
                      InfoRow(title: 'ID монеты', value: trade.coin.id),
                      InfoRow(
                        title: 'Цена монеты',
                        value: trade.coinPrice.price,
                      ),
                      InfoRow(
                        title: 'Общая цена',
                        value: trade.totalPrice.price,
                      ),
                      InfoRow(title: 'Дата', value: trade.createdAtFormat),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
