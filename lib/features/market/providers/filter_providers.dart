import 'package:flutter_riverpod/legacy.dart';
import '../../../data/models/crypto_coin_details.dart';

final sortCryptoCoinsProvider = StateProvider<SortType>((ref) => SortType.marketCap);

final searchCoinsProvider = StateProvider<String>((ref) => '');
