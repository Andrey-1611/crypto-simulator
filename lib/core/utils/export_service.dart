import 'dart:io';

import 'package:Bitmark/app/runner/app_dependencies.dart';
import 'package:Bitmark/core/utils/extensions.dart';
import 'package:Bitmark/data/models/trade.dart';
import 'package:csv/csv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

final exportServiceProvider = Provider<ExportService>(
  (ref) => ExportService(share: ref.read(shareProvider)),
);

class ExportService {
  final SharePlus _share;

  ExportService({required SharePlus share}) : _share = share;

  Future<void> exportTrades(List<Trade> trades) async {
    final rows = [
      ['ID', 'Date', 'Type', 'Coin', 'Amount', 'Price', 'Total Price'],
      ...trades.map(
        (t) => [
          t.id,
          t.createdAt.csvFormat,
          t.type.name,
          t.coin.symbol,
          t.amount,
          t.coinPrice.toStringAsFixed(6),
          t.totalPrice.toStringAsFixed(6),
        ],
      ),
    ];
    final csv = excel.encode(rows);
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/trades.csv');
    await file.writeAsString(csv);

    await _share.share(ShareParams(files: [XFile(file.path)]));
  }
}
