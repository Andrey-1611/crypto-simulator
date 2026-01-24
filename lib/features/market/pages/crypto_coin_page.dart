import 'package:auto_route/annotations.dart';
import 'package:crypto_simulator/app/widgets/info_bloc.dart';
import 'package:crypto_simulator/app/widgets/loader.dart';
import 'package:crypto_simulator/app/widgets/unknown_error.dart';
import 'package:crypto_simulator/core/utils/price_formatter.dart';
import 'package:crypto_simulator/data/models/crypto_coin_details.dart';
import 'package:crypto_simulator/features/market/widgets/buy_crypto_coin_sheet.dart';
import 'package:crypto_simulator/features/market/widgets/sell_crypto_coin_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/widgets/info_row.dart';
import '../../../data/models/crypto_coin.dart';
import '../../briefcase/providers/briefcase_provider.dart';
import '../providers/crypto_coin_details_provider.dart';

@RoutePage()
class CryptoCoinPage extends ConsumerWidget {
  final CryptoCoin coin;

  const CryptoCoinPage({super.key, required this.coin});

  void refresh(WidgetRef ref) => ref.refresh(cryptoCoinDetailsProvider(coin));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final coinP = ref.watch(cryptoCoinDetailsProvider(coin));
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox.square(
              dimension: size.height * 0.05,
              child: Image.network(coin.fullImageUrl),
            ),
            SizedBox(width: size.width * 0.01),
            Expanded(child: Text(coin.name, overflow: TextOverflow.ellipsis)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => refresh(ref),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const .all(16.0),
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
    final isUp = coin.changePercent24h >= 0;
    final color = isUp ? Colors.green : Colors.red;
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const .all(8),
        child: ListTile(
          title: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                coin.currentPrice.price,
                style: theme.textTheme.displayLarge,
              ),
              Container(
                padding: const .symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: .circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      isUp ? Icons.trending_up : Icons.trending_down,
                      color: color,
                    ),
                    SizedBox(width: size.width * 0.01),
                    Text(
                      coin.changePercent24h.percent,
                      style: theme.textTheme.bodyMedium?.copyWith(color: color),
                    ),
                  ],
                ),
              ),
            ],
          ),
          subtitle: Text(
            '${isUp ? '+' : '-'}\$${coin.priceChange24h.abs().toStringAsFixed(2)}',
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
    return Column(
      children: [
        InfoBloc(
          title: 'Рыночные данные',
          children: [
            InfoRow(
              title: 'Капитализация',
              value: CryptoCoinDetails.formatValue(coin.marketCap),
            ),
            InfoRow(
              title: 'Объем (24ч)',
              value: CryptoCoinDetails.formatValue(coin.volume24h),
            ),
            InfoRow(
              title: 'В обращении',
              value: CryptoCoinDetails.formatValue(coin.circulatingSupply),
            ),
            InfoRow(
              title: 'Максимум (24ч)',
              value: CryptoCoinDetails.formatValue(coin.high24h),
            ),
            InfoRow(
              title: 'Минимум (24ч)',
              value: CryptoCoinDetails.formatValue(coin.low24h),
            ),
          ],
        ),
        InfoBloc(
          title: 'Информация',
          children: [
            InfoRow(title: 'Символ', value: coin.symbol),
            InfoRow(title: 'ID', value: coin.id),
          ],
        ),
      ],
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
    final userP = ref.watch(briefcaseNotifierProvider);
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
              child: const Text('Купить'),
            ),
          ),
        ),
        userP.when(
          data: (user) {
            final userCoin = user?.findCoin(coin);
            return userCoin?.amount != 0
                ? Flexible(
                    flex: 1,
                    child: Container(
                      margin: const .all(16),
                      width: double.infinity / 3,
                      height: size.height * 0.05,
                      child: ElevatedButton(
                        onPressed: () => showSellCoinSheet(context),
                        child: const Text('Продать'),
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
