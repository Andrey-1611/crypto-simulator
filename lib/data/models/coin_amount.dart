import 'package:Bitmark/data/models/crypto_coin.dart';

class CoinAmount {
  final CryptoCoin coin;
  final int amount;

  CoinAmount({required this.coin, required this.amount});

  factory CoinAmount.empty() => CoinAmount(coin: CryptoCoin.empty(), amount: 0);

  CoinAmount copyWith({CryptoCoin? coin, int? amount}) {
    return CoinAmount(coin: coin ?? this.coin, amount: amount ?? this.amount);
  }

  Map<String, dynamic> toJson() {
    return {'coin': coin.toJson(), 'amount': amount};
  }

  factory CoinAmount.fromJson(Map<String, dynamic> map) {
    return CoinAmount(
      coin: CryptoCoin.fromJson(map['coin']),
      amount: map['amount'] as int,
    );
  }
}
