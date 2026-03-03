import 'package:Bitmark/app/router/app_router.dart';
import 'package:Bitmark/app/widgets/size_box.dart';
import 'package:Bitmark/features/market/providers/compare_coins_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/extensions.dart';
import '../../data/models/crypto_coin.dart';

class CoinCard extends ConsumerWidget {
  final CryptoCoin coin;
  final double price;

  const CoinCard({super.key, required this.coin, required this.price});

  void push(BuildContext context, WidgetRef ref) {
    final stack = context.router.stack;
    final prevRoute = stack.length > 1 ? stack[stack.length - 2] : null;
    if (prevRoute != null && prevRoute.name == CompareCoinsRoute.name) {
      ref.read(compareCoinsNotifierProvider.notifier).addCoin(coin);
    } else {
      context.pushRoute(CoinDetailsRoute(coin: coin));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        leading: SizeBox.square(
          size: 0.14,
          child: Image.network(coin.fullImageUrl),
        ),
        title: Text(coin.name),
        subtitle: Text(price.price4),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => push(context, ref),
      ),
    );
  }
}
