import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/widgets/size_box.dart';
import '../../../core/utils/extensions.dart';
import '../../../data/models/app_user_details.dart';
import '../providers/filter_coins_provider.dart';

class FilterCoinsSheet extends ConsumerStatefulWidget {
  final AppUserDetails? user;

  const FilterCoinsSheet({super.key, this.user});

  @override
  ConsumerState createState() => _FilterTradesSheetState();
}

class _FilterTradesSheetState extends ConsumerState<FilterCoinsSheet> {
  final coinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(filterCoinsOnSheetProvider.notifier).state = ref
        .read(filterCoinsProvider.notifier)
        .state;
  }

  void apply() {
    ref.read(filterCoinsProvider.notifier).state = ref
        .read(filterCoinsOnSheetProvider.notifier)
        .state;
    context.pop();
  }

  void reset() {
    ref.read(filterCoinsOnSheetProvider.notifier).state = .initial();
    coinController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filter = ref.watch(filterCoinsOnSheetProvider);
    final notifier = ref.read(filterCoinsOnSheetProvider.notifier);
    coinController.value = coinController.value.copyWith(text: filter.coinName);
    return Padding(
      padding: const .only(bottom: 64, left: 16, right: 16, top: 16),
      child: Column(
        mainAxisSize: .min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Фильтры', style: theme.textTheme.displayMedium),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => context.pop(context),
              ),
            ],
          ),
          const SizeBox(height: 0.03),
          TextField(
            controller: coinController,
            textInputAction: TextInputAction.search,
            onChanged: (value) =>
                notifier.state = notifier.state.copyWith(coinName: value),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Поиск монеты',
              suffixIcon: IconButton(
                onPressed: () {
                  coinController.clear();
                  notifier.state = notifier.state.copyWith(coinName: '');
                },
                icon: const Icon(Icons.close),
              ),
            ),
          ),
          const SizeBox(height: 0.02),
          const Text('Цена за монету'),
          RangeSlider(
            values: filter.priceRange ?? const RangeValues(0, 1000),
            min: 0,
            max: 1000,
            divisions: 1000,
            labels: RangeLabels(
              (filter.priceRange?.start ?? 0).price,
              (filter.priceRange?.end ?? 1000).price,
            ),
            onChanged: (values) {
              notifier.state = notifier.state.copyWith(priceRange: values);
            },
          ),
          const SizeBox(height: 0.02),
          const Text('Общая цена'),
          RangeSlider(
            values: filter.totalPriceRange ?? const RangeValues(0, 2000),
            min: 0,
            max: 2000,
            divisions: 2000,
            labels: RangeLabels(
              (filter.totalPriceRange?.start ?? 0).price,
              (filter.totalPriceRange?.end ?? 2000).price,
            ),
            onChanged: (values) {
              notifier.state = notifier.state.copyWith(totalPriceRange: values);
            },
          ),
          const SizeBox(height: 0.02),
          const Text('Количество монет'),
          RangeSlider(
            values: filter.amountRange ?? const RangeValues(0, 3000),
            min: 0,
            max: 3000,
            divisions: 3000,
            labels: RangeLabels(
              (filter.amountRange?.start ?? 0).toStringAsFixed(0),
              (filter.amountRange?.end ?? 3000).toStringAsFixed(0),
            ),
            onChanged: (values) {
              notifier.state = notifier.state.copyWith(amountRange: values);
            },
          ),
          const SizeBox(height: 0.02),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => reset(),
                  child: const Text('Сбросить'),
                ),
              ),
              const SizeBox(width: 0.05),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => apply(),
                  child: const Text('Применить'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
