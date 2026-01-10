import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/market_provider.dart';

class MarketSortSheet extends ConsumerWidget {
  const MarketSortSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = ref.watch(sortCoinsProvider);
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    return Padding(
      padding: const .all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Сортировка', style: theme.textTheme.displaySmall),
          SizedBox(height: size.height * 0.02),
          RadioGroup<SortType>(
            groupValue: sort,
            onChanged: (v) => ref.read(sortCoinsProvider.notifier).state = v!,
            child: const Column(
              children: [
                RadioListTile(
                  value: SortType.marketCap,
                  title: Text('По капитализации'),
                ),
                RadioListTile(value: SortType.price, title: Text('По цене')),
                RadioListTile(
                  value: SortType.change24h,
                  title: Text('Изменение за 24ч'),
                ),
                RadioListTile(value: SortType.volume, title: Text('По объёму')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
