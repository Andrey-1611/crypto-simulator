import 'package:Bitmark/app/widgets/size_box.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../core/utils/extensions.dart';
import '../../data/models/crypto_coin.dart';
import '../router/app_router.dart';

class CryptoCoinCard extends StatelessWidget {
  final CryptoCoin coin;
  final double price;

  const CryptoCoinCard({super.key, required this.coin, required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: SizeBox.square(
          size: 0.14,
          child: Image.network(coin.fullImageUrl),
        ),
        title: Text(coin.name),
        subtitle: Text(price.price4),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.pushRoute(CryptoCoinRoute(coin: coin)),
      ),
    );
  }
}
