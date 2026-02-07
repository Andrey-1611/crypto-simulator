import 'package:Bitmark/core/utils/extensions.dart';
import 'package:auto_route/auto_route.dart';
import 'package:Bitmark/app/router/app_router.dart';
import 'package:Bitmark/app/widgets/unknown_error.dart';
import 'package:Bitmark/data/models/app_user_details.dart';
import 'package:Bitmark/features/briefcase/providers/trades_provider.dart';
import 'package:Bitmark/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/widgets/loader.dart';

class TradesHistoryPage extends ConsumerWidget {
  final AppUserDetails? user;

  const TradesHistoryPage({super.key, this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tradesP = ref.watch(tradesProvider(user?.id));
    return tradesP.when(
      data: (trades) => trades.isNotEmpty
          ? ListView.builder(
              itemCount: trades.length,
              itemBuilder: (context, index) {
                final trade = trades[index];
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
                    subtitle: Text(trade.createdAt.format),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.pushRoute(TradeRoute(trade: trade)),
                  ),
                );
              },
            )
          : _EmptyList(user),
      error: (_, _) => const UnknownError(),
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
        Text(s.empty_trades(user != null), style: theme.textTheme.displayLarge),
        user == null
            ? TextButton(
                onPressed: () {
                  AutoTabsRouter.of(context).setActiveIndex(0);
                },
                child: Text(s.perform),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
