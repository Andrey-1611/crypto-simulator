import 'package:auto_route/annotations.dart';
import 'package:crypto_simulator/app/widgets/loader.dart';
import 'package:crypto_simulator/app/widgets/unknown_error.dart';
import 'package:crypto_simulator/data/models/crypto_coin.dart';
import 'package:crypto_simulator/features/market/providers/market_provider.dart';
import 'package:crypto_simulator/features/market/widgets/buy_crypto_coin_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class CryptoCoinPage extends ConsumerWidget {
  final CryptoCoin coin;

  const CryptoCoinPage({super.key, required this.coin});

  void refresh(WidgetRef ref) =>
      ref.read(marketNotifierProvider.notifier).updateCoinPrice(coin);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final marketP = ref.watch(marketNotifierProvider);
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
        child: marketP.when(
          data: (coins) {
            final newCoin = coins.firstWhere((e) => e.id == coin.id);
            return Column(
              children: [
                _PriceCard(coin: newCoin),
                _MarketDataCard(coin: newCoin),
                _CoinInfoCard(coin: newCoin),
                _BuyButton(coin: newCoin),
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
  final CryptoCoin coin;

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
                '\$${coin.currentPrice.toStringAsFixed(3)}',
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
                      '${coin.changePercent24h.toStringAsFixed(2)} %',
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

class _MarketDataCard extends StatelessWidget {
  final CryptoCoin coin;

  const _MarketDataCard({required this.coin});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    return Card(
      child: Padding(
        padding: const .all(16),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text('Рыночные данные', style: theme.textTheme.bodyLarge),
            SizedBox(height: size.height * 0.02),
            _DataRow(label: 'Капитализация', value: coin.marketCap),
            _DataRow(label: 'Объем (24ч)', value: coin.volume24h),
            _DataRow(label: 'В обращении', value: coin.circulatingSupply),
            _DataRow(label: 'Максимум (24ч)', value: coin.high24h),
            _DataRow(label: 'Минимум (24ч)', value: coin.low24h),
          ],
        ),
      ),
    );
  }
}

class _CoinInfoCard extends StatelessWidget {
  final CryptoCoin coin;

  const _CoinInfoCard({required this.coin});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    return Card(
      child: Padding(
        padding: const .all(16),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text('Информация', style: theme.textTheme.bodyLarge),
            SizedBox(height: size.height * 0.02),
            _InfoRow(label: 'Символ', value: coin.symbol),
            _InfoRow(label: 'ID', value: coin.id),
            SizedBox(height: size.height * 0.02),
          ],
        ),
      ),
    );
  }
}

class _DataRow extends StatelessWidget {
  final String label;
  final double value;

  const _DataRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const .symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(label, style: theme.textTheme.bodyMedium),
          Text(CryptoCoin.formatValue(value), style: theme.textTheme.bodyLarge),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const .symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(label, style: theme.textTheme.bodyMedium),
          Text(value, style: theme.textTheme.bodyLarge),
        ],
      ),
    );
  }
}

class _BuyButton extends StatelessWidget {
  final CryptoCoin coin;

  const _BuyButton({required this.coin});

  void showBuyCoinSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => BuyCryptoCoinSheet(coin: coin),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      margin: const EdgeInsets.all(16),
      width: double.infinity,
      height: size.height * 0.05,
      child: ElevatedButton(
        onPressed: () => showBuyCoinSheet(context),
        child: const Text('Купить'),
      ),
    );
  }
}
