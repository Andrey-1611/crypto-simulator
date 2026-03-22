import 'package:Bitmark/app/widgets/coin_card.dart';
import 'package:Bitmark/app/widgets/loader.dart';
import 'package:Bitmark/app/widgets/search_field.dart';
import 'package:Bitmark/app/widgets/unknown_error.dart';
import 'package:Bitmark/core/utils/dialog_helper.dart';
import 'package:Bitmark/core/utils/toast_helper.dart';
import 'package:Bitmark/features/market/providers/compare_coins_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/router/app_router.dart';
import '../../../core/utils/extensions.dart';
import '../../../generated/l10n.dart';
import '../providers/search_coins_provider.dart';

@RoutePage()
class SearchCoinsPage extends ConsumerStatefulWidget {
  const SearchCoinsPage({super.key});

  @override
  ConsumerState createState() => _SearchCoinsPageState();
}

class _SearchCoinsPageState extends ConsumerState<SearchCoinsPage> {
  final searchController = TextEditingController();

  void search() =>
      ref.read(queryProvider.notifier).state = searchController.text.trim();

  @override
  void initState() {
    searchController.text = ref.read(queryProvider);
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searchCoinsP = ref.watch(searchCoinProvider);
    final s = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(s.search_coins),
        bottom: PreferredSize(
          preferredSize: .fromHeight(60.sp),
          child: Padding(
            padding: .all(8.sp),
            child: Row(
              children: [
                Expanded(
                  child: SearchField(
                    controller: searchController,
                    onSubmitted: (_) => search,
                    reset: () => searchController.clear(),
                  ),
                ),
                IconButton.filled(
                  onPressed: search,
                  icon: const Icon(Icons.search),
                  style: ButtonStyle(
                    shape: .all(
                      RoundedRectangleBorder(borderRadius: .circular(8.sp)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: .all(16.sp),
        child: Center(
          child: searchCoinsP.when(
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
          ),
        ),
      ),
    );
  }
}

class _EmptyList extends ConsumerWidget {
  const _EmptyList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final s = S.of(context);
    final isSearch = ref.watch(queryProvider) != '';
    return Column(
      mainAxisAlignment: .center,
      children: [
        Text(
          isSearch ? s.no_coins_found : s.start_searching_coins,
          style: theme.textTheme.displayLarge,
        ),
      ],
    );
  }
}
