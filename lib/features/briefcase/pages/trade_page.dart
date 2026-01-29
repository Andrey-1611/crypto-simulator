import 'package:auto_route/annotations.dart';
import 'package:crypto_simulator/app/widgets/crypto_coin_card.dart';
import 'package:crypto_simulator/app/widgets/info_row.dart';
import 'package:crypto_simulator/app/widgets/loader.dart';
import 'package:crypto_simulator/app/widgets/unknown_error.dart';
import 'package:crypto_simulator/core/utils/formatter.dart';
import 'package:crypto_simulator/data/models/trade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/widgets/size_box.dart';
import '../../../generated/l10n.dart';
import '../providers/crypto_coin_price_provider.dart';

@RoutePage()
class TradePage extends ConsumerWidget {
  final Trade trade;

  const TradePage({super.key, required this.trade});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final s = S.of(context);
    final coinP = ref.watch(cryptoCoinPriceProvider(trade.coin.symbol));
    return Scaffold(
      appBar: AppBar(title: Text(s.trade_details)),
      body: Padding(
        padding: const .all(16),
        child: Center(
          child: Column(
            children: [
              SizeBox(
                height: 0.11,
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
                      Text(s.data, style: theme.textTheme.bodyLarge),
                      const SizeBox(height: 0.02),
                      InfoRow(
                        title: S.of(context).type,
                        value: trade.type.type,
                      ),
                      InfoRow(title: s.amount, value: trade.amount.toString()),
                      InfoRow(title: s.coin, value: trade.coin.symbol),
                      InfoRow(title: s.coin_id, value: trade.coin.id),
                      InfoRow(
                        title: s.coin_price,
                        value: trade.coinPrice.price4,
                      ),
                      InfoRow(
                        title: s.total_price,
                        value: trade.totalPrice.price4,
                      ),
                      InfoRow(title: s.date, value: trade.createdAt.date),
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
