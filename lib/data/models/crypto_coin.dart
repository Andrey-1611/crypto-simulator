import 'package:crypto_simulator/core/constants/api_constants.dart';
import 'package:crypto_simulator/features/market/providers/market_provider.dart';

class CryptoCoin {
  final String id;
  final String symbol;
  final String name;
  final String imageUrl;
  final double currentPrice;
  final double changePercent24h;
  final double priceChange24h;
  final double high24h;
  final double low24h;
  final double marketCap;
  final double volume24h;
  final double circulatingSupply;

  String get fullImageUrl => '${ApiConstants.imagesHost}/$imageUrl';

  const CryptoCoin({
    required this.id,
    required this.symbol,
    required this.name,
    required this.imageUrl,
    required this.currentPrice,
    required this.changePercent24h,
    required this.priceChange24h,
    required this.high24h,
    required this.low24h,
    required this.marketCap,
    required this.volume24h,
    required this.circulatingSupply,
  });

  @override
  String toString() {
    return 'CryptoCoin{'
        ' id: $id,'
        ' symbol: $symbol,'
        ' name: $name,'
        ' imageUrl: $imageUrl,'
        ' currentPrice: $currentPrice,'
        ' changePercent24h: $changePercent24h,'
        ' priceChange24h: $priceChange24h,'
        ' high24h: $high24h,'
        ' low24h: $low24h,'
        ' marketCap: $marketCap,'
        ' volume24h: $volume24h,'
        ' circulatingSupply: $circulatingSupply,'
        '}';
  }

  CryptoCoin copyWith({
    String? id,
    String? symbol,
    String? name,
    String? imageUrl,
    double? currentPrice,
    double? changePercent24h,
    double? priceChange24h,
    double? high24h,
    double? low24h,
    double? marketCap,
    double? volume24h,
    double? circulatingSupply,
  }) {
    return CryptoCoin(
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
      'imageUrl': imageUrl,
      'currentPrice': currentPrice,
      'changePercent24h': changePercent24h,
      'priceChange24h': priceChange24h,
      'high24h': high24h,
      'low24h': low24h,
      'marketCap': marketCap,
      'volume24h': volume24h,
      'circulatingSupply': circulatingSupply,
    };
  }

  factory CryptoCoin.fromMap(Map<String, dynamic> map) {
    return CryptoCoin(
      id: map['id'] as String,
      symbol: map['symbol'] as String,
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String,
      currentPrice: map['currentPrice'] as double,
      changePercent24h: map['changePercent24h'] as double,
      priceChange24h: map['priceChange24h'] as double,
      high24h: map['high24h'] as double,
      low24h: map['low24h'] as double,
      marketCap: map['marketCap'] as double,
      volume24h: map['volume24h'] as double,
      circulatingSupply: map['circulatingSupply'] as double,
    );
  }

  factory CryptoCoin.fromListAPI(Map<String, dynamic> map) {
    final info = map['CoinInfo'] as Map<String, dynamic>;
    final data = map['RAW']['USD'] as Map<String, dynamic>;
    return CryptoCoin(
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

  factory CryptoCoin.fromCoinAPI(Map<String, dynamic> map, CryptoCoin coin) {
    return CryptoCoin(
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

  static List<CryptoCoin> filterCryptoCoins(
    List<CryptoCoin> coins,
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
        SortType.volume => b.volume24h.compareTo(a.volume24h),
      },
    );
    return coins;
  }

  static String formatValue(double value) {
    return switch (value) {
      >= 1000000000000 =>
        '\$${(value / 1000000000000).toStringAsFixed(2)} трлн',
      >= 1000000000 => '\$${(value / 1000000000).toStringAsFixed(2)} млрд',
      >= 1000000 => '\$${(value / 1000000).toStringAsFixed(2)} млн',
      >= 1000 => '\$${(value / 1000).toStringAsFixed(2)} тыс',
      _ => '\$${value.toStringAsFixed(2)}',
    };
  }
}

enum SortType { marketCap, price, change24h, volume }
