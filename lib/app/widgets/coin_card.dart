import 'package:Bitmark/app/router/app_router.dart';
import 'package:Bitmark/app/widgets/size_box.dart';
import 'package:Bitmark/features/briefcase/providers/favourite_provider.dart';
import 'package:Bitmark/features/market/providers/compare_coins_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/extensions.dart';
import '../../data/models/crypto_coin.dart';
import '../../features/market/providers/profit_provider.dart';

class CoinCard extends ConsumerWidget {
  final CryptoCoin coin;
  final double price;
  final bool? isFavourite;

  const CoinCard({
    super.key,
    required this.coin,
    required this.price,
    this.isFavourite,
  });

  void push(BuildContext context, WidgetRef ref) {
    if (context.fromRoute(const CompareCoinsRoute())) {
      ref.read(compareCoinsNotifierProvider.notifier).addCoin(coin);
    } else if (context.fromRoute(const TradesSimulatorRoute())) {
      ref.read(profitStateProvider.notifier).state = ref
          .read(profitStateProvider)
          .copyWith(coinSymbol: coin.symbol);
      context.pop();
    } else {
      context.pushRoute(CoinDetailsRoute(coin: coin));
    }
  }

  void remove(WidgetRef ref) => ref
      .read(favouriteNotifierProvider.notifier)
      .toggleIsFavourite(coin, price);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    return Card(
      child: ListTile(
        leading: SizeBox.square(
          size: 0.14,
          child: Image.network(coin.fullImageUrl),
        ),
        title: Text(coin.name),
        subtitle: Text(price.price4),
        trailing: isFavourite ?? false
            ? IconButton(
                onPressed: () => remove(ref),
                icon: Icon(
                  Icons.favorite_outlined,
                  color: theme.colorScheme.error,
                ),
              )
            : const Icon(Icons.chevron_right),
        onTap: () => push(context, ref),
      ),
    );
  }
}
