import 'package:Bitmark/data/models/app_user_details.dart';
import 'package:Bitmark/data/models/trade.dart';
import 'package:Bitmark/features/briefcase/providers/briefcase_provider.dart';
import 'package:Bitmark/features/history/providers/filter_trades_provider.dart';
import 'package:Bitmark/features/history/providers/sort_trades_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tradesProvider =
    FutureProvider.family<
      ({List<Trade> trades, bool isFilterd}),
      AppUserDetails?
    >((ref, user) async {
      final data = await ref.read(briefcaseNotifierProvider(user).future);
      final filter = ref.watch(filterTradesProvider);
      final sort = ref.watch(sortTradesProvider);
      final filtered = Trade.filterTrades(data.trades, filter);
      final sorted = Trade.sortTrades(filtered, sort);
      final isFiltered = data.trades.length != sorted.length;
      return (trades: sorted, isFilterd: isFiltered);
    });
