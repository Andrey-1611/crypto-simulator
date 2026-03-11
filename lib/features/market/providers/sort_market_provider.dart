import 'package:flutter_riverpod/legacy.dart';
import '../../../data/models/crypto_coin_details.dart';

final sortMarketProvider = StateProvider<SortType>((ref) => .marketCap);