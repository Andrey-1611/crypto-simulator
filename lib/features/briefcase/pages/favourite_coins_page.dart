import 'package:Bitmark/app/widgets/coin_card.dart';
import 'package:Bitmark/features/briefcase/providers/favourite_provider.dart';
import 'package:Bitmark/generated/l10n.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/router/app_router.dart';
import '../../../app/widgets/loader.dart';
import '../../../app/widgets/unknown_error.dart';
import '../../../core/utils/dialog_helper.dart';
import '../../../core/utils/toast_helper.dart';
import '../../market/providers/compare_coins_provider.dart';

@RoutePage()
/*
class FavouriteCoinsPage extends ConsumerWidget {
  const FavouriteCoinsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteP = ref.watch(favouriteNotifierProvider);
    final s = S.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(s.favourite)),
      body: Padding(
        padding: .all(16.sp),
        child: Center(
          child: favouriteP.when(
            data: (coins) => coins.isNotEmpty
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
            error: (e, _) => UnknownError(error: e),
            loading: () => const Loader(),
          ),
        ),
      ),
    );
  }
}
*/
class FavouriteCoinsPage extends ConsumerStatefulWidget {
  const FavouriteCoinsPage({super.key});

  @override
  ConsumerState createState() => _FavouriteCoinsPageState();
}

class _FavouriteCoinsPageState extends ConsumerState<FavouriteCoinsPage> {
  @override
  void initState() {
    super.initState();
    if (isFromCompare(context)) {
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

  bool isFromCompare(BuildContext context) {
    final stack = context.router.stack;
    return stack.length >= 2 &&
        stack[stack.length - 2].name == CompareCoinsRoute.name;
  }

  @override
  Widget build(BuildContext context) {
    final favouriteP = ref.watch(favouriteNotifierProvider);
    final s = S.of(context);
    final fromCompare = isFromCompare(context);
    return fromCompare
        ? Scaffold(
            appBar: AppBar(title: Text(s.favourite)),
            body: Padding(
              padding: .all(16.sp),
              child: Center(
                child: favouriteP.when(
                  data: (coins) => coins.isNotEmpty
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
                  error: (e, _) => UnknownError(error: e),
                  loading: () => const Loader(),
                ),
              ),
            ),
          )
        : favouriteP.when(
            data: (coins) => coins.isNotEmpty
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
