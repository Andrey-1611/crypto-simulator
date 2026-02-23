import 'package:Bitmark/core/utils/extensions.dart';
import 'package:Bitmark/features/briefcase/providers/favourite_provider.dart';
import 'package:auto_route/annotations.dart';
import 'package:Bitmark/app/widgets/info_bloc.dart';
import 'package:Bitmark/app/widgets/loader.dart';
import 'package:Bitmark/app/widgets/unknown_error.dart';
import 'package:Bitmark/data/models/crypto_coin_details.dart';
import 'package:Bitmark/features/market/widgets/buy_coin_sheet.dart';
import 'package:Bitmark/features/market/widgets/sell_coin_sheet.dart';
import 'package:Bitmark/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/widgets/info_row.dart';
import '../../../app/widgets/size_box.dart';
import '../../../data/models/crypto_coin.dart';
import '../../briefcase/providers/briefcase_provider.dart';
import '../providers/coin_details_provider.dart';

@RoutePage()
class CryptoCoinPage extends ConsumerWidget {
  final CryptoCoin coin;

  const CryptoCoinPage({super.key, required this.coin});

  void refresh(WidgetRef ref) => ref.refresh(coinDetailsProvider(coin));

  void toggle(WidgetRef ref, CryptoCoin coin, double price) => ref
      .read(favouriteNotifierProvider.notifier)
      .toggleIsFavourite(coin, price);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coinP = ref.watch(coinDetailsProvider(coin));
    final favouriteP = ref.watch(favouriteNotifierProvider);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizeBox.square(size: 0.1, child: Image.network(coin.fullImageUrl)),
            const SizeBox(width: 0.01),
            Expanded(child: Text(coin.name, overflow: TextOverflow.ellipsis)),
          ],
        ),
        actions: [
          coinP.when(
            data: (coin) => favouriteP.when(
              data: (coins) {
                final ids = coins.map((c) => c.coin.id);
                final isFavourite = ids.contains(coin.info.id);
                return IconButton(
                  onPressed: () => toggle(ref, coin.info, coin.priceData.price),
                  icon: Icon(
                    isFavourite ? Icons.favorite : Icons.favorite_border,
                    color: isFavourite ? theme.colorScheme.error : null,
                  ),
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (_, _) => const SizedBox.shrink(),
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, _) => const SizedBox.shrink(),
          ),
          IconButton(
            onPressed: () => refresh(ref),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: .all(16.0.sp),
        child: coinP.when(
          data: (coin) {
            return Column(
              children: [
                _PriceCard(coin: coin),
                _DataBlocs(coin: coin),
                _ActionsButtons(coin: coin),
              ],
            );
          },
          error: (_, _) => UnknownError(onPressed: () {}),
          loading: () => const Loader(),
        ),
      ),
    );
  }
}

class _PriceCard extends StatelessWidget {
  final CryptoCoinDetails coin;

  const _PriceCard({required this.coin});

  @override
  Widget build(BuildContext context) {
    final isUp = coin.priceData.changePct24h >= 0;
    final color = isUp ? Colors.green : Colors.red;
    final theme = context.theme;
    return Card(
      child: Padding(
        padding: .all(8.sp),
        child: ListTile(
          title: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                coin.priceData.price.price4,
                style: theme.textTheme.displayLarge,
              ),
              Container(
                padding: .symmetric(horizontal: 12.sp, vertical: 8.sp),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: .circular(8.sp),
                ),
                child: Row(
                  children: [
                    Icon(
                      isUp ? Icons.trending_up : Icons.trending_down,
                      color: color,
                    ),
                    const SizeBox(width: 0.01),
                    Text(
                      coin.priceData.changePct24h.percent,
                      style: theme.textTheme.bodyMedium?.copyWith(color: color),
                    ),
                  ],
                ),
              ),
            ],
          ),
          subtitle: Text(
            '${isUp ? '+' : '-'}\$${coin.priceData.change24h.abs().toStringAsFixed(2)}',
            style: theme.textTheme.bodyMedium?.copyWith(color: color),
          ),
        ),
      ),
    );
  }
}

class _DataBlocs extends StatelessWidget {
  final CryptoCoinDetails coin;

  const _DataBlocs({required this.coin});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Expanded(
      child: ListView(
        children: [
          InfoBloc(
            title: s.market_data,
            children: [
              InfoRow(
                title: s.price,
                value: coin.priceData.price.toCryptoPrice,
              ),
              InfoRow(
                title: s.open_24h,
                value: coin.priceData.open24h.toCryptoPrice,
              ),
              InfoRow(
                title: s.change_24h,
                value: coin.priceData.change24h.toCryptoPrice,
              ),
              InfoRow(
                title: s.change_24h_pct,
                value: coin.priceData.changePct24h.percent,
              ),
              InfoRow(
                title: s.high_24h,
                value: coin.priceData.high24h.toCryptoPrice,
              ),
              InfoRow(
                title: s.low_24h,
                value: coin.priceData.low24h.toCryptoPrice,
              ),
            ],
          ),
          InfoBloc(
            title: s.daily_data,
            children: [
              InfoRow(
                title: s.open_day,
                value: coin.dailyData.openDay.toCryptoPrice,
              ),
              InfoRow(
                title: s.high_day,
                value: coin.dailyData.highDay.toCryptoPrice,
              ),
              InfoRow(
                title: s.low_day,
                value: coin.dailyData.lowDay.toCryptoPrice,
              ),
              InfoRow(
                title: s.day_change,
                value: coin.dailyData.changeDay.toCryptoPrice,
              ),
              InfoRow(
                title: s.day_change_pct,
                value: coin.dailyData.changePctDay.percent,
              ),
            ],
          ),
          InfoBloc(
            title: s.volume_data,
            children: [
              InfoRow(
                title: s.volume_hour,
                value: coin.volumeData.volumeHour.toCryptoPrice,
              ),
              InfoRow(
                title: s.volume_24h,
                value: coin.volumeData.volume24h.toCryptoPrice,
              ),
              InfoRow(
                title: s.top_tier_volume_24h,
                value: coin.volumeData.topTierVolume24h.toCryptoPrice,
              ),
              InfoRow(
                title: s.volume_day,
                value: coin.volumeData.volumeDay.toCryptoPrice,
              ),
            ],
          ),
          InfoBloc(
            title: s.supply_data,
            children: [
              InfoRow(title: s.supply, value: coin.supplyData.supply.toCrypto),
              InfoRow(
                title: s.circulating_supply,
                value: coin.supplyData.circulatingSupply.toCrypto,
              ),
              InfoRow(
                title: s.market_cap,
                value: coin.supplyData.marketCap.toCryptoPrice,
              ),
              InfoRow(
                title: s.circulating_supply_cap,
                value: coin.supplyData.circulatingSupplyMarketCap.toCryptoPrice,
              ),
            ],
          ),

          InfoBloc(
            title: s.information,
            children: [
              InfoRow(title: s.name, value: coin.info.name),
              InfoRow(title: s.symbol, value: coin.info.symbol),
              InfoRow(title: s.id, value: coin.info.id),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionsButtons extends ConsumerWidget {
  final CryptoCoinDetails coin;

  const _ActionsButtons({required this.coin});

  void showBuyCoinSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => BuyCryptoCoinSheet(coin: coin),
    );
  }

  void showSellCoinSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SellCryptoCoinSheet(coin: coin),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final userP = ref.watch(briefcaseNotifierProvider(null));
    final s = S.of(context);
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: Container(
            margin: const .all(16),
            width: double.infinity / 3,
            height: size.height * 0.05,
            child: ElevatedButton(
              onPressed: () => showBuyCoinSheet(context),
              child: Text(s.buy),
            ),
          ),
        ),
        userP.when(
          data: (data) {
            final userCoin = data.user.findCoin(coin.info);
            return userCoin.amount != 0
                ? Flexible(
                    flex: 1,
                    child: Container(
                      margin: const .all(16),
                      width: double.infinity / 3,
                      height: size.height * 0.05,
                      child: ElevatedButton(
                        onPressed: () => showSellCoinSheet(context),
                        child: Text(s.sell),
                      ),
                    ),
                  )
                : const SizedBox.shrink();
          },
          error: (_, _) => const UnknownError(),
          loading: () => const Loader(),
        ),
      ],
    );
  }
}
