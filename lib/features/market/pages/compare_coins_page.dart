import 'package:Bitmark/app/router/app_router.dart';
import 'package:Bitmark/app/widgets/loader.dart';
import 'package:Bitmark/app/widgets/unknown_error.dart';
import 'package:Bitmark/features/market/providers/compare_coins_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class CompareCoinsPage extends ConsumerWidget {

  const CompareCoinsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final compareCoinsP = ref.watch(compareCoinsNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Сравнение монет'),
        actions: [
          IconButton(
            onPressed: () => context.pushRoute(const SearchCoinsRoute()),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Center(
          child: compareCoinsP.when(
            data: (coins) =>
                Text(coins.map((c) => c.coin.info.symbol).toList().join(', ')),
            error: (e, _) => UnknownError(error: e),
            loading: () => const Loader(),
          ),
        ),
      ),
    );
  }
}
