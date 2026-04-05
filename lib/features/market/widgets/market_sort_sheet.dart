import 'package:Bitmark/features/market/providers/market_provider.dart';
import 'package:Bitmark/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/widgets/size_box.dart';
import '../../../core/utils/extensions.dart';
import '../../../data/models/crypto_coin_details.dart';
import '../providers/sort_market_provider.dart';

class MarketSortSheet extends ConsumerWidget {
  const MarketSortSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = ref.watch(sortMarketProvider);
    final s = S.of(context);
    return Padding(
      padding: .all(16.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(s.sort, style: context.displaySmall),
          const SizeBox(height: 0.02),
          RadioGroup<SortType>(
            groupValue: sort,
            onChanged: (sortType) {
              ref.read(sortMarketProvider.notifier).state = sortType!;
              ref.read(marketNotifierProvider.notifier).changeSort(sortType);
            },
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
                RadioListTile(
                  value: SortType.volume24h,
                  title: Text(s.by_volume),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
