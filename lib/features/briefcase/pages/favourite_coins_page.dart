import 'package:Bitmark/app/widgets/coin_card.dart';
import 'package:Bitmark/features/briefcase/providers/favourite_provider.dart';
import 'package:Bitmark/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/widgets/loader.dart';
import '../../../app/widgets/unknown_error.dart';

class FavouriteCoinsPage extends ConsumerWidget {
  const FavouriteCoinsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteP = ref.watch(favouriteNotifierProvider);
    return favouriteP.when(
      data: (coins) => coins.isNotEmpty
          ? ListView.builder(
              itemCount: coins.length,
              itemBuilder: (context, index) {
                final coin = coins[index];
                return CoinCard(coin: coin.coin, price: coin.price);
              },
            )
          : const _EmptyList(),
      error: (e, _) => UnknownError(error: e),
      loading: () => const Loader(),
    );
  }
}

class _EmptyList extends StatelessWidget {
  const _EmptyList();

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(s.no_favourite_coins, style: theme.textTheme.displayLarge),
      ],
    );
  }
}
