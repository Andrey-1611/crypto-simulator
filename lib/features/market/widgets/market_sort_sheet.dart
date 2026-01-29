import 'package:crypto_simulator/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/widgets/size_box.dart';
import '../../../data/models/crypto_coin_details.dart';
import '../providers/filter_providers.dart';

class MarketSortSheet extends ConsumerWidget {
  const MarketSortSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = ref.watch(sortCoinsProvider);
    final theme = Theme.of(context);
    final s = S.of(context);
    return Padding(
      padding: const .all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(s.sort, style: theme.textTheme.displaySmall),
          const SizeBox(height: 0.02),
          RadioGroup<SortType>(
            groupValue: sort,
            onChanged: (v) => ref.read(sortCoinsProvider.notifier).state = v!,
            child: Column(
              children: [
                RadioListTile(
                  value: SortType.marketCap,
                  title: Text(s.by_market_cap),
                ),
                RadioListTile(value: SortType.price, title: Text(s.by_price)),
                RadioListTile(
                  value: SortType.change24h,
                  title: Text(s.by_change_24h),
                ),
                RadioListTile(value: SortType.volume24h, title: Text(s.by_volume)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
