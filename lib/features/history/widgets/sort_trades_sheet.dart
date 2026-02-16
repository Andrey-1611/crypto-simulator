import 'package:Bitmark/features/history/providers/sort_trades_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/widgets/size_box.dart';
import '../../../generated/l10n.dart';

class SortTradesSheet extends ConsumerWidget {
  const SortTradesSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = ref.watch(sortTradesProvider);
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
          RadioGroup<TradeSortType>(
            groupValue: sort,
            onChanged: (v) => ref.read(sortTradesProvider.notifier).state = v!,
            child: const Column(
              children: [
                RadioListTile(
                  value: TradeSortType.newestFirst,
                  title: Text('Сначала новые'),
                ),
                RadioListTile(
                  value: TradeSortType.oldestFirst,
                  title: Text('Сначала старые'),
                ),
                RadioListTile(
                  value: TradeSortType.highestTotal,
                  title: Text('Сначала большие суммы'),
                ),
                RadioListTile(
                  value: TradeSortType.lowestTotal,
                  title: Text('Сначала маленькие суммы'),
                ),
                RadioListTile(
                  value: TradeSortType.highestAmount,
                  title: Text('Сначала больше монет'),
                ),
                RadioListTile(
                  value: TradeSortType.lowestAmount,
                  title: Text('Сначала меньше монет'),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
