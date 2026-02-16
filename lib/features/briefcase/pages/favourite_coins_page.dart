import 'package:Bitmark/app/widgets/crypto_coin_card.dart';
import 'package:Bitmark/features/briefcase/providers/favourite_provider.dart';
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
                return CryptoCoinCard(coin: coin.coin, price: coin.price);
              },
            )
          : const _EmptyList(),
      error: (_, _) => const UnknownError(),
      loading: () => const Loader(),
    );
  }
}

class _EmptyList extends StatelessWidget {
  const _EmptyList();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('У вас нет избранных монет', style: theme.textTheme.displayLarge),
      ],
    );
  }
}
