import 'package:Bitmark/app/widgets/coin_card.dart';
import 'package:Bitmark/core/utils/extensions.dart';
import 'package:Bitmark/features/briefcase/providers/favourite_provider.dart';
import 'package:Bitmark/generated/l10n.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/router/app_router.dart';
import '../../../core/utils/dialog_helper.dart';
import '../../../core/utils/toast_helper.dart';
import '../../market/providers/compare_coins_provider.dart';

@RoutePage()
class FavouriteCoinsPage extends ConsumerStatefulWidget {
  const FavouriteCoinsPage({super.key});

  @override
  ConsumerState createState() => _FavouriteCoinsPageState();
}

class _FavouriteCoinsPageState extends ConsumerState<FavouriteCoinsPage> {
  @override
  void initState() {
    super.initState();
    if (context.fromRoute(const CompareCoinsRoute())) {
      ref.listenManual(compareCoinsNotifierProvider, (_, state) {
        state.when(
          data: (_) {
            context.pop();
            context.pop();
          },
          error: (_, _) {
            context.pop();
            ToastHelper.unknownError();
          },
          loading: () => DialogHelper.loading(context),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final needToChange =
        context.fromRoute(const CompareCoinsRoute()) ||
        context.fromRoute(const TradesSimulatorRoute());
    return needToChange
        ? Scaffold(
            appBar: AppBar(title: Text(s.favourite)),
            body: Padding(
              padding: .all(16.sp),
              child: Center(
                child: ref.watchWhen(
                  favouriteNotifierProvider,
                  builder: (coins) => coins.isNotEmpty
                      ? ListView.builder(
                          itemCount: coins.length,
                          itemBuilder: (context, index) {
                            final coin = coins[index];
                            return CoinCard(
                              coin: coin.coin,
                              price: coin.price,
                              isFavourite: true,
                            );
                          },
                        )
                      : const _EmptyList(),
                ),
              ),
            ),
          )
        : ref.watchWhen(
            favouriteNotifierProvider,
            builder: (coins) => coins.isNotEmpty
                ? ListView.builder(
                    itemCount: coins.length,
                    itemBuilder: (context, index) {
                      final coin = coins[index];
                      return CoinCard(
                        coin: coin.coin,
                        price: coin.price,
                        isFavourite: true,
                      );
                    },
                  )
                : const _EmptyList(),
          );
  }
}

class _EmptyList extends StatelessWidget {
  const _EmptyList();

  @override
  Widget build(BuildContext context) {
    final s = context.s;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(s.no_favourite_coins, style: context.displayLarge),
      ],
    );
  }
}
