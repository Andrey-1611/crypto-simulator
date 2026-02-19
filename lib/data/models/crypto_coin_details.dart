import 'package:json_annotation/json_annotation.dart';

import 'crypto_coin.dart';

part 'crypto_coin_details.g.dart';

@JsonSerializable()
class CryptoCoinDetails extends CryptoCoin {
  final double currentPrice;
  final double changePercent24h;
  final double priceChange24h;
  final double high24h;
  final double low24h;
  final double marketCap;
  final double volume24h;
  final double circulatingSupply;

  const CryptoCoinDetails({
    required super.id,
    required super.symbol,
    required super.name,
    required super.imageUrl,
    required this.currentPrice,
    required this.changePercent24h,
    required this.priceChange24h,
    required this.high24h,
    required this.low24h,
    required this.marketCap,
    required this.volume24h,
    required this.circulatingSupply,
  });

  CryptoCoin get info =>
      CryptoCoin(id: id, symbol: symbol, name: name, imageUrl: imageUrl);

  CryptoCoinDetails copyWith({
    String? id,
    String? symbol,
    String? name,
    String? imageUrl,
    bool? isFavourite,
    double? currentPrice,
    double? changePercent24h,
    double? priceChange24h,
    double? high24h,
    double? low24h,
    double? marketCap,
    double? volume24h,
    double? circulatingSupply,
  }) {
    return CryptoCoinDetails(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      currentPrice: currentPrice ?? this.currentPrice,
      changePercent24h: changePercent24h ?? this.changePercent24h,
      priceChange24h: priceChange24h ?? this.priceChange24h,
      high24h: high24h ?? this.high24h,
      low24h: low24h ?? this.low24h,
      marketCap: marketCap ?? this.marketCap,
      volume24h: volume24h ?? this.volume24h,
      circulatingSupply: circulatingSupply ?? this.circulatingSupply,
    );
  }

  @override
  Map<String, dynamic> toJson() => _$CryptoCoinDetailsToJson(this);

  factory CryptoCoinDetails.fromJson(Map<String, dynamic> json) =>
      _$CryptoCoinDetailsFromJson(json);

  factory CryptoCoinDetails.fromCoinAPI(
    Map<String, dynamic> map,
    CryptoCoin coin,
  ) {
    return CryptoCoinDetails(
      id: coin.id,
      symbol: coin.symbol,
      name: coin.name,
      imageUrl: coin.imageUrl,
      currentPrice: (map['PRICE'] as num).toDouble(),
      changePercent24h: (map['CHANGEPCT24HOUR'] as num).toDouble(),
      priceChange24h: (map['CHANGE24HOUR'] as num).toDouble(),
      high24h: (map['HIGH24HOUR'] as num).toDouble(),
      low24h: (map['LOW24HOUR'] as num).toDouble(),
      marketCap: (map['MKTCAP'] as num).toDouble(),
      circulatingSupply: (map['CIRCULATINGSUPPLY'] as num).toDouble(),
      volume24h: (map['VOLUME24HOURTO'] as num).toDouble(),
    );
  }

  factory CryptoCoinDetails.fromListAPI(Map<String, dynamic> map) {
    final info = map['CoinInfo'] as Map<String, dynamic>;
    final data = map['RAW']['USD'] as Map<String, dynamic>;
    return CryptoCoinDetails(
      id: info['Id'] as String,
      symbol: info['Name'] as String,
      name: info['FullName'] as String,
      imageUrl: info['ImageUrl'] as String,
      currentPrice: (data['PRICE'] as num).toDouble(),
      changePercent24h: (data['CHANGEPCT24HOUR'] as num).toDouble(),
      priceChange24h: (data['CHANGE24HOUR'] as num).toDouble(),
      high24h: (data['HIGH24HOUR'] as num).toDouble(),
      low24h: (data['LOW24HOUR'] as num).toDouble(),
      marketCap: (data['MKTCAP'] as num).toDouble(),
      circulatingSupply: (data['CIRCULATINGSUPPLY'] as num).toDouble(),
      volume24h: (data['VOLUME24HOURTO'] as num).toDouble(),
    );
  }

  static List<CryptoCoinDetails> filterCryptoCoins(
    List<CryptoCoinDetails> coins,
    SortType sort,
    String search,
  ) {
    coins = coins
        .where((coin) => coin.name.toLowerCase().contains(search.toLowerCase()))
        .toList();
    coins.sort(
      (a, b) => switch (sort) {
        SortType.marketCap => b.marketCap.compareTo(a.marketCap),
        SortType.price => b.currentPrice.compareTo(a.currentPrice),
        SortType.change24h => b.priceChange24h.abs().compareTo(
          a.priceChange24h.abs(),
        ),
        SortType.volume24h => b.volume24h.compareTo(a.volume24h),
      },
    );
    return coins;
  }
}

enum SortType { marketCap, price, change24h, volume24h }
