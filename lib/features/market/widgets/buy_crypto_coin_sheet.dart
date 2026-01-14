import 'package:crypto_simulator/app/widgets/loader.dart';
import 'package:crypto_simulator/app/widgets/unknown_error.dart';
import 'package:crypto_simulator/data/models/crypto_coin.dart';
import 'package:crypto_simulator/features/user/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BuyCryptoCoinSheet extends ConsumerStatefulWidget {
  final CryptoCoin coin;

  const BuyCryptoCoinSheet({super.key, required this.coin});

  @override
  ConsumerState createState() => _BuyCryptoCoinSheetState();
}

class _BuyCryptoCoinSheetState extends ConsumerState<BuyCryptoCoinSheet> {
  final _coinsController = TextEditingController();

  double _totalPrice = 0;

  @override
  void initState() {
    super.initState();
    _coinsController.addListener(() {
      _totalPrice = int.parse(_coinsController.text) * widget.coin.currentPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userP = ref.read(userNotifierProvider);
    return Padding(
      padding: const .all(32),
      child: userP.when(
        data: (user) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Покупка ${widget.coin.name}',
              style: theme.textTheme.displayMedium,
            ),
            const Spacer(),
            TextField(
              controller: _coinsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Количество монет'),
            ),
            _RowInfo(title: 'Баланс', value: user!.balance),
            _RowInfo(title: 'Сделка', value: _totalPrice),
            ElevatedButton(onPressed: () {}, child: const Text('Подтвердить')),
            const Spacer(),
          ],
        ),
        error: (_, _) => UnknownError(onPressed: () {}),
        loading: () => const Loader(),
      ),
    );
  }
}

class _RowInfo extends StatelessWidget {
  final String title;
  final double value;

  const _RowInfo({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const .all(8),
        child: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text(title),
            Text('$value \$', style: theme.textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
