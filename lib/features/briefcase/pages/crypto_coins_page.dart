import 'package:auto_route/auto_route.dart';
import 'package:Bitmark/app/widgets/loader.dart';
import 'package:Bitmark/app/widgets/unknown_error.dart';
import 'package:Bitmark/data/models/app_user_details.dart';
import 'package:Bitmark/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/router/app_router.dart';
import '../../../core/utils/extensions.dart';
import '../providers/crypto_coins_provider.dart';

class CryptoCoinsPage extends ConsumerWidget {
  final AppUserDetails? user;

  const CryptoCoinsPage({super.key, this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final coinsP = ref.watch(cryptoCoinsProvider(user));
    final s = S.of(context);
    return coinsP.when(
      data: (coins) => coins.isNotEmpty
          ? ListView.builder(
              itemCount: coins.length,
              itemBuilder: (context, index) {
                final coin = coins[index].coin.coin;
                final amount = coins[index].coin.amount;
                final price = coins[index].price;
                return Card(
                  child: ListTile(
                    leading: SizedBox.square(
                      dimension: size.height * 0.06,
                      child: Image.network(coin.fullImageUrl),
                    ),
                    title: Text(coin.name),
                    subtitle: Text('${price.price4}, ${s.coins_a(amount)}'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.pushRoute(CryptoCoinRoute(coin: coin)),
                  ),
                );
              },
            )
          : _EmptyList(user),
      error: (_, _) =>
          UnknownError(onPressed: () => ref.refresh(cryptoCoinsProvider(user))),
      loading: () => const Loader(),
    );
  }
}

class _EmptyList extends StatelessWidget {
  final AppUserDetails? user;

  const _EmptyList(this.user);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final s = S.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(s.no_coins(user != null), style: theme.textTheme.displayLarge),
        user == null
            ? TextButton(
                onPressed: () {
                  AutoTabsRouter.of(context).setActiveIndex(0);
                },
                child: Text(s.buy),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
