import 'package:Bitmark/app/widgets/size_box.dart';
import 'package:Bitmark/data/models/app_user_details.dart';
import 'package:Bitmark/data/models/trade.dart';
import 'package:Bitmark/features/history/providers/filter_trades_provider.dart';
import 'package:Bitmark/generated/l10n.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/extensions.dart';

class FilterTradesSheet extends ConsumerStatefulWidget {
  final AppUserDetails? user;

  const FilterTradesSheet({super.key, this.user});

  @override
  ConsumerState createState() => _FilterTradesSheetState();
}

class _FilterTradesSheetState extends ConsumerState<FilterTradesSheet> {
  final coinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(filterTradesOnSheetProvider.notifier).state = ref
        .read(filterTradesProvider.notifier)
        .state;
  }

  Future<DateTime?> showPicker(DateTime? date) async => await showDatePicker(
    context: context,
    initialDate: date ?? .now(),
    firstDate: DateTime(2020),
    lastDate: .now(),
  );

  Future<void> pickDateRange() async {
    final notifier = ref.read(filterTradesOnSheetProvider.notifier);
    final picked = await showDateRangePicker(
      context: context,
      initialEntryMode: .calendarOnly,
      initialDateRange: notifier.state.dateRange,
      firstDate: DateTime(2020),
      lastDate: .now(),
      builder: (context, child) {
        final theme = Theme.of(context);
        return Theme(
          data: theme.copyWith(
            textTheme: TextTheme(
              titleLarge: theme.textTheme.titleLarge?.apply(
                fontSizeFactor: 0.3,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      notifier.state = notifier.state.copyWith(dateRange: picked);
    }
  }

  void apply() {
    ref.read(filterTradesProvider.notifier).state = ref
        .read(filterTradesOnSheetProvider.notifier)
        .state;
    context.pop();
  }

  void reset() {
    ref.read(filterTradesOnSheetProvider.notifier).state = .initial();
    coinController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);
    final filter = ref.watch(filterTradesOnSheetProvider);
    final notifier = ref.read(filterTradesOnSheetProvider.notifier);
    coinController.value = coinController.value.copyWith(text: filter.coinName);
    return Padding(
      padding: const .only(bottom: 64, left: 16, right: 16, top: 16),
      child: Column(
        mainAxisSize: .min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(s.filters, style: theme.textTheme.displayMedium),
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
              hintText: s.search_coin,
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
          Row(
            mainAxisAlignment: .center,
            children: TradeType.values.map((type) {
              final selected = filter.tradeType == type;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ChoiceChip(
                  selectedColor: theme.primaryColor,
                  label: Text(type.type),
                  selected: selected,
                  onSelected: (_) =>
                      notifier.state = notifier.state.copyWith(tradeType: type),
                ),
              );
            }).toList(),
          ),
          const SizeBox(height: 0.02),
          TextButton(
            onPressed: pickDateRange,
            child: Text(
              filter.dateRange == null
                  ? s.select_period
                  : '${filter.dateRange!.start.dayFormat} - '
                        '${filter.dateRange!.end.dayFormat}',
            ),
          ),
          const SizeBox(height: 0.02),
          Text(s.total_price),
          RangeSlider(
            values: filter.totalPriceRange ?? const RangeValues(0, 2000),
            min: 0,
            max: 2000,
            divisions: 2000,
            labels: RangeLabels(
              (filter.totalPriceRange?.start ?? 0).price,
              (filter.totalPriceRange?.end ?? 1000).price,
            ),
            onChanged: (values) {
              notifier.state = notifier.state.copyWith(totalPriceRange: values);
            },
          ),
          const SizeBox(height: 0.02),
          Text(s.coin_amount),
          RangeSlider(
            values: filter.amountRange ?? const RangeValues(0, 10000),
            min: 0,
            max: 10000,
            divisions: 10000,
            labels: RangeLabels(
              (filter.amountRange?.start ?? 0).toStringAsFixed(0),
              (filter.amountRange?.end ?? 100).toStringAsFixed(0),
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
                  child: Text(s.reset),
                ),
              ),
              const SizeBox(width: 0.05),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => apply(),
                  child: Text(s.apply),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
