import 'package:Bitmark/features/briefcase/providers/sort_coins_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/widgets/size_box.dart';
import '../../../generated/l10n.dart';

class SortCoinsSheet extends ConsumerWidget {
  const SortCoinsSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = ref.watch(sortCoinsProvider);
    final theme = Theme.of(context);
    final s = S.of(context);
    return Padding(
      padding: .all(16.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(s.sort, style: theme.textTheme.displayMedium),
          const SizeBox(height: 0.02),
          RadioGroup<CoinSortType>(
            groupValue: sort,
            onChanged: (v) => ref.read(sortCoinsProvider.notifier).state = v!,
            child: const Column(
              children: [
                RadioListTile(
                  value: CoinSortType.moreCoins,
                  title: Text('Сначала больше монет'),
                ),
                RadioListTile(
                  value: CoinSortType.lessCoins,
                  title: Text('Сначала меньше монет'),
                ),
                RadioListTile(
                  value: CoinSortType.highPrice,
                  title: Text('Сначала дорогие'),
                ),
                RadioListTile(
                  value: CoinSortType.lowPrice,
                  title: Text('Сначала дешёвые'),
                ),
                RadioListTile(
                  value: CoinSortType.highTotal,
                  title: Text('Сначала большая сумма'),
                ),
                RadioListTile(
                  value: CoinSortType.lowTotal,
                  title: Text('Сначала маленькая сумма'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
