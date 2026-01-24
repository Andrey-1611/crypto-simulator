import 'package:auto_route/auto_route.dart';
import 'package:crypto_simulator/app/router/app_router.dart';
import 'package:crypto_simulator/app/widgets/unknown_error.dart';
import 'package:crypto_simulator/data/models/app_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/widgets/loader.dart';
import '../providers/briefcase_provider.dart';

class TradesHistoryPage extends ConsumerWidget {
  final AppUser? userA;
  const TradesHistoryPage({super.key, this.userA});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userP = ref.watch(briefcaseNotifierProvider(userA));
    return userP.when(
      data: (user) => user!.trades.isNotEmpty ? ListView.builder(
        itemCount: user.trades.length,
        itemBuilder: (context, index) {
          final trade = user.trades[index];
          return Card(
            child: ListTile(
              leading: GestureDetector(
                onTap: () =>
                    context.pushRoute(CryptoCoinRoute(coin: trade.coin)),
                child: Image.network(trade.coin.fullImageUrl),
              ),
              title: Text(
                '${trade.type.type} ${trade.amount} ${trade.coin.name}',
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(trade.createdAtFormat),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.pushRoute(TradeRoute(trade: trade)),
            ),
          );
        },
      ) : _EmptyList(userA),
      error: (_, _) => const UnknownError(),
      loading: () => const Loader(),
    );
  }
}

class _EmptyList extends StatelessWidget {
  final AppUser? user;

  const _EmptyList(this.user);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${user == null ? 'У вас е' : 'Е'}ще нет операций',
          style: theme.textTheme.displayLarge,
        ),
        user == null
            ? TextButton(
          onPressed: () {
            context.pushRoute(const MarketRoute());
          },
          child: const Text('Совершить'),
        )
            : const SizedBox.shrink(),
      ],
    );
  }
}

