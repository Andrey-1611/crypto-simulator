import 'package:Bitmark/data/repositories/crypto_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final profitProvider = FutureProvider<Profit?>((ref) async {
  final state = ref.read(profitStateProvider);
  if (!state.isValid) return null;
  final results = await Future.wait([
    ref
        .read(cryptoRepositoryProvider)
        .getCoinHistoryPrice(state.coinSymbol!, state.buyDate!),
    ref
        .read(cryptoRepositoryProvider)
        .getCoinHistoryPrice(state.coinSymbol!, state.sellDate!),
  ]);
  final buyPrice = results[0].close;
  final sellPrice = results[1].close;
  return Profit.from(
    buyPrice: buyPrice,
    sellPrice: sellPrice,
    amount: state.amount!,
    sellDate: state.sellDate!,
    buyDate: state.buyDate!,
  );
});

final profitStateProvider = StateProvider<ProfitState>((_) => ProfitState());

class ProfitState {
  final String? coinSymbol;
  final int? amount;
  final DateTime? buyDate;
  final DateTime? sellDate;

  ProfitState({this.coinSymbol, this.amount, this.buyDate, this.sellDate});

  ProfitState copyWith({
    String? coinSymbol,
    int? amount,
    DateTime? buyDate,
    DateTime? sellDate,
  }) {
    return ProfitState(
      coinSymbol: coinSymbol ?? this.coinSymbol,
      amount: amount ?? this.amount,
      buyDate: buyDate ?? this.buyDate,
      sellDate: sellDate ?? this.sellDate,
    );
  }

  bool get isValid =>
      coinSymbol != null &&
      amount != null &&
      buyDate != null &&
      sellDate != null;
}

class Profit {
  final double buyPrice;
  final double sellPrice;

  final double buyTotalPrice;
  final double sellTotalPrice;

  final double profit;
  final double profitPct;

  final double profitPerCoin;
  final double profitPerCoinPct;

  final double profitPerHour;
  final double profitPerDay;
  final double profitPerMonth;

  Profit({
    required this.buyTotalPrice,
    required this.sellTotalPrice,
    required this.profit,
    required this.profitPct,
    required this.profitPerCoin,
    required this.profitPerCoinPct,
    required this.profitPerHour,
    required this.profitPerDay,
    required this.profitPerMonth,
    required this.buyPrice,
    required this.sellPrice,
  });

  factory Profit.from({
    required double buyPrice,
    required double sellPrice,
    required int amount,
    required DateTime buyDate,
    required DateTime sellDate,
  }) {
    final buyTotalPrice = buyPrice * amount;
    final sellTotalPrice = sellPrice * amount;

    final profit = sellTotalPrice - buyTotalPrice;
    final profitPct = (profit / buyTotalPrice) * 100;

    final profitPerCoin = sellPrice - buyPrice;
    final profitPerCoinPct = ((sellPrice - buyPrice) / buyPrice) * 100;

    final hours = sellDate.difference(buyDate).inHours.toDouble();
    final safeHours = hours <= 0 ? 1 : hours;

    final profitPerHour = profit / safeHours;
    final profitPerDay = profitPerHour * 24;
    final profitPerMonth = profitPerDay * 30;

    return Profit(
      buyPrice: buyPrice,
      sellPrice: sellPrice,
      buyTotalPrice: buyTotalPrice,
      sellTotalPrice: sellTotalPrice,
      profit: profit,
      profitPct: profitPct,
      profitPerCoin: profitPerCoin,
      profitPerCoinPct: profitPerCoinPct,
      profitPerHour: profitPerHour,
      profitPerDay: profitPerDay,
      profitPerMonth: profitPerMonth,
    );
  }
}
