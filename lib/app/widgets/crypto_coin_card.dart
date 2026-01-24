import 'package:auto_route/auto_route.dart';
import 'package:crypto_simulator/core/utils/price_formatter.dart';
import 'package:flutter/material.dart';
import '../../data/models/crypto_coin.dart';
import '../router/app_router.dart';

class CryptoCoinCard extends StatelessWidget {
  final CryptoCoin coin;
  final double price;

  const CryptoCoinCard({super.key, required this.coin, required this.price});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Card(
      child: ListTile(
        leading: SizedBox.square(
          dimension: size.height * 0.06,
          child: Image.network(coin.fullImageUrl),
        ),
        title: Text(coin.name),
        subtitle: Text(price.price),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.pushRoute(CryptoCoinRoute(coin: coin)),
      ),
    );
  }
}
