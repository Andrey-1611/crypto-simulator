import 'package:Bitmark/app/widgets/size_box.dart';
import 'package:Bitmark/data/models/trade.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../core/utils/extensions.dart';
import '../router/app_router.dart';

class TradeCard extends StatelessWidget {
  final Trade trade;

  const TradeCard({super.key, required this.trade});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: GestureDetector(
          onTap: () => context.pushRoute(CoinDetailsRoute(coin: trade.coin)),
          child: SizeBox.square(
            size: 0.14,
            child: Image.network(trade.coin.fullImageUrl),
          ),
        ),
        title: Text(
          '${trade.type.type} ${trade.amount} ${trade.coin.name}',
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(trade.createdAt.hourFormat),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.pushRoute(TradeRoute(trade: trade)),
      ),
    );
  }
}
