import 'package:Bitmark/app/widgets/info_bloc.dart';
import 'package:Bitmark/app/widgets/info_row.dart';
import 'package:Bitmark/app/widgets/size_box.dart';
import 'package:Bitmark/app/widgets/trade_card.dart';
import 'package:Bitmark/core/utils/coin_trades_utils.dart';
import 'package:Bitmark/core/utils/extensions.dart';
import 'package:Bitmark/data/models/crypto_coin_details.dart';
import 'package:Bitmark/data/models/trade.dart';
import 'package:Bitmark/features/briefcase/providers/briefcase_provider.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class CoinHistoryPage extends ConsumerWidget {
  final CryptoCoinDetails coin;

  const CoinHistoryPage({super.key, required this.coin});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = context.s;
    return Scaffold(
      appBar: AppBar(title: Text('${s.history} ${coin.info.name}')),
      body: Padding(
        padding: .all(16.r),
        child: Center(
          child: ref.watchWhen(
            briefcaseNotifierProvider(null),
            builder: (data) {
              final coinTrades = data.trades
                  .where((t) => t.coin.id == coin.info.id)
                  .toList();
              return coinTrades.isNotEmpty
                  ? ListView(
                      children: [
                        _InfoBlocs(coin: coin, trades: coinTrades),
                        const SizeBox(height: 0.02),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: coinTrades.length,
                          itemBuilder: (context, index) {
                            final trade = coinTrades[index];
                            return TradeCard(trade: trade);
                          },
                        ),
                      ],
                    )
                  : const _EmptyList();
            },
          ),
        ),
      ),
    );
  }
}

class _EmptyList extends StatelessWidget {
  const _EmptyList();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final s = context.s;
    return Text(s.no_trades, style: theme.textTheme.displayLarge);
  }
}

class _InfoBlocs extends StatelessWidget {
  final CryptoCoinDetails coin;
  final List<Trade> trades;

  const _InfoBlocs({required this.coin, required this.trades});

  @override
  Widget build(BuildContext context) {
    final s = context.s;
    final util = CoinTradesUtils(coin: coin, trades: trades);
    return Column(
      mainAxisSize: .min,
      children: [
        InfoBloc(
          title: s.trade_data,
          children: [
            InfoRow(title: s.trades, value: util.tradesCount.toString()),
            InfoRow(title: s.bought, value: util.totalBought.toString()),
            InfoRow(title: s.sold, value: util.totalSold.toString()),
            InfoRow(title: s.balance, value: util.amount.toString()),
          ],
        ),

        InfoBloc(
          title: s.financial_data,
          children: [
            InfoRow(title: s.spent, value: util.totalSpent.toCryptoPrice),
            InfoRow(title: s.received, value: util.totalReceived.toCryptoPrice),
            InfoRow(
              title: s.average_price,
              value: util.avgBuyPrice.toCryptoPrice,
            ),
            InfoRow(title: s.profit, value: util.pnl.toCryptoPrice),
            InfoRow(title: s.profitability, value: util.pnlPercent.percent),
          ],
        ),
      ],
    );
  }
}
