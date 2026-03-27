import 'package:Bitmark/data/repositories/crypto_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final profitProvider = FutureProvider<double>((ref) async {
  final state = ref.read(profitStateProvider);
  if (!state.isValid) return 0;
  final results = await Future.wait([
    ref
        .read(cryptoRepositoryProvider)
        .getCoinHistoryPrice(state.coinSymbol!, state.buyDate!),
    ref
        .read(cryptoRepositoryProvider)
        .getCoinHistoryPrice(state.coinSymbol!, state.sellDate!),
  ]);
  final buyPrice = results[0];
  final sellPrice = results[1];
  return (sellPrice.close - buyPrice.close) * state.amount!;
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
