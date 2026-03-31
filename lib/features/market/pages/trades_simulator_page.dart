import 'package:Bitmark/app/widgets/info_bloc.dart';
import 'package:Bitmark/app/widgets/info_row.dart';
import 'package:Bitmark/app/widgets/loader.dart';
import 'package:Bitmark/core/utils/datetime_service.dart';
import 'package:Bitmark/core/utils/extensions.dart';
import 'package:Bitmark/data/models/trade.dart';
import 'package:Bitmark/features/market/providers/profit_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/router/app_router.dart';

@RoutePage()
class TradesSimulatorPage extends ConsumerStatefulWidget {
  const TradesSimulatorPage({super.key});

  @override
  ConsumerState createState() => _TradesSimulatorPageState();
}

class _TradesSimulatorPageState extends ConsumerState<TradesSimulatorPage> {
  final _amountController = TextEditingController();

  void selectDate(BuildContext context, TradeType type) async {
    final dateHour = await ref
        .read(datetimeServiceProvider)
        .pickDateHour(context);
    final provider = ref.read(profitStateProvider);
    ref.read(profitStateProvider.notifier).state = type == .buy
        ? provider.copyWith(buyDate: dateHour)
        : provider.copyWith(sellDate: dateHour);
  }

  void update(String text) => ref
      .read(profitStateProvider.notifier)
      .update((st) => st.copyWith(amount: int.parse(text)));

  void clearAll() {
    ref.invalidate(profitStateProvider);
    ref.invalidate(profitProvider);
    _amountController.clear();
  }

  @override
  void initState() {
    super.initState();
    if (!ref.read(profitStateProvider).isValid) {
      Future.microtask(() {
        ref
            .read(profitStateProvider.notifier)
            .update((st) => st.copyWith(sellDate: DateTime.now()));
      });
    }
    final amount = ref.read(profitStateProvider).amount;
    _amountController.text = amount != null ? amount.toString() : '';
    _amountController.addListener(() {
      ref
          .read(profitStateProvider.notifier)
          .update(
            (st) => st.copyWith(amount: int.parse(_amountController.text)),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = context.s;
    final state = ref.watch(profitStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(s.simulator_trades),
        actions: [
          IconButton(
            onPressed: clearAll,
            icon: const Icon(Icons.delete_forever),
          ),
        ],
      ),
      body: Padding(
        padding: .all(16.r),
        child: Center(
          child: Column(
            children: [
              const _InfoBloc(),
              SizedBox(height: 40.h),
              TextField(
                readOnly: true,
                controller: TextEditingController(text: state.coinSymbol),
                decoration: InputDecoration(
                  suffixIcon: PopupMenuButton<SelectCoinPopup>(
                    icon: const Icon(Icons.add),
                    onSelected: (value) => switch (value) {
                      .market => context.pushRoute(const MarketRoute()),
                      .search => context.pushRoute(const SearchCoinsRoute()),
                      .favourite => context.pushRoute(
                        const FavouriteCoinsRoute(),
                      ),
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(value: .market, child: Text(s.market)),
                      PopupMenuItem(value: .search, child: Text(s.searching)),
                      PopupMenuItem(
                        value: .favourite,
                        child: Text(s.favourite),
                      ),
                    ],
                  ),
                  hintText: s.coin,
                ),
              ),
              SizedBox(height: 15.h),
              TextField(
                controller: _amountController,
                autofocus: false,
                keyboardType: .number,
                maxLength: 12,
                onChanged: update,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: s.num_coins,
                  counterText: '',
                ),
              ),
              SizedBox(height: 15.h),
              TextField(
                readOnly: true,
                controller: TextEditingController(
                  text: state.buyDate?.hourFormat,
                ),
                onTap: () => selectDate(context, .buy),
                decoration: InputDecoration(hintText: s.buy_date),
              ),
              SizedBox(height: 15.h),
              TextField(
                readOnly: true,
                controller: TextEditingController(
                  text: state.sellDate?.hourFormat,
                ),
                onTap: () => selectDate(context, .sell),
                decoration: InputDecoration(hintText: s.sell_date),
              ),
              SizedBox(height: 15.h),
              SizedBox(
                height: 40.h,
                child: ref.watch(profitProvider).isLoading
                    ? const Loader()
                    : ElevatedButton(
                        onPressed: () => ref.refresh(profitProvider),
                        child: Text(s.calculate),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum SelectCoinPopup { market, search, favourite }

class _InfoBloc extends ConsumerWidget {
  const _InfoBloc();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = context.s;
    final theme = context.theme;
    return SizedBox(
      height: 410.h,
      child: ref.watchWhen(
        profitProvider,
        builder: (data) => data != null
            ? InfoBloc(
                title: s.profit_data,
                children: [
                  InfoRow(
                    title: s.buy_price,
                    value: data.buyPrice.compactPrice,
                  ),
                  InfoRow(
                    title: s.sell_price,
                    value: data.sellPrice.compactPrice,
                  ),
                  InfoRow(title: s.profit, value: data.profit.compactPrice),
                  InfoRow(
                    title: s.profit_percent,
                    value: data.profitPct.percent,
                  ),
                  InfoRow(
                    title: s.profit_per_coin,
                    value: data.profitPerCoin.compactPrice,
                  ),
                  InfoRow(
                    title: s.profit_per_hour,
                    value: data.profitPerHour.compactPrice,
                  ),
                  InfoRow(
                    title: s.profit_per_day,
                    value: data.profitPerDay.compactPrice,
                  ),
                  InfoRow(
                    title: s.profit_per_month,
                    value: data.profitPerMonth.compactPrice,
                  ),
                ],
              )
            : Center(
                child: Text(
                  s.create_trade,
                  style: theme.textTheme.displayLarge,
                ),
              ),
      ),
    );
  }
}
