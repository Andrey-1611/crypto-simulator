import 'package:Bitmark/app/widgets/info_bloc.dart';
import 'package:Bitmark/core/utils/dialog_helper.dart';
import 'package:auto_route/annotations.dart';
import 'package:Bitmark/app/widgets/coin_card.dart';
import 'package:Bitmark/app/widgets/info_row.dart';
import 'package:Bitmark/data/models/trade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/extensions.dart';
import '../../../generated/l10n.dart';
import '../providers/trade_provider.dart';

@RoutePage()
class TradePage extends ConsumerWidget {
  final Trade trade;

  const TradePage({super.key, required this.trade});

  void showTradeDialog(BuildContext context) {
    trade.type == .buy
        ? DialogHelper.buyCoin(
            context: context,
            coin: trade.coin,
            coinPrice: trade.coinPrice,
            amount: trade.amount,
          )
        : DialogHelper.sellCoin(
            context: context,
            coin: trade.coin,
            coinPrice: trade.coinPrice,
            amount: trade.amount,
          );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(s.trade_details),
        actions: [
          IconButton(
            onPressed: () => showTradeDialog(context),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: .all(16.sp),
        child: Center(
          child: ref.watchWhen(
            tradeProvider(trade),
            builder: (data) {
              final currentPrice = data.coin.price;
              return Column(
                children: [
                  CoinCard(coin: trade.coin, price: (currentPrice)),
                  InfoBloc(
                    title: s.data,
                    children: [
                      InfoRow(title: s.type, value: trade.type.type),
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
                      InfoRow(title: s.date, value: trade.createdAt.hourFormat),
                    ],
                  ),
                  InfoBloc(
                    title: s.current_indicators,
                    children: [
                      InfoRow(
                        title: s.current_price,
                        value: currentPrice.price4,
                      ),
                      InfoRow(
                        title: s.current_total_price,
                        value: trade.currentTotalPrice(currentPrice).price2,
                      ),
                      InfoRow(
                        title: s.profit,
                        value: trade.profit(currentPrice).price2,
                      ),
                      InfoRow(
                        title: s.profit_percent,
                        value: trade.profitPercent(currentPrice).percent,
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
