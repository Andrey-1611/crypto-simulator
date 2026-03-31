import 'crypto_coin.dart';

class CryptoCoinDetails {
  final CryptoCoin info;
  final PriceData priceData;
  final HourlyData hourlyData;
  final DailyData dailyData;
  final VolumeData volumeData;
  final SupplyData supplyData;

  CryptoCoinDetails({
    required this.info,
    required this.priceData,
    required this.volumeData,
    required this.supplyData,
    required this.hourlyData,
    required this.dailyData,
  });

  factory CryptoCoinDetails.fromAPI({
    required Map<String, dynamic> map,
    CryptoCoin? coin,
  }) {
    final info = map['CoinInfo'] as Map<String, dynamic>?;
    final data = map['RAW']?['USD'] as Map<String, dynamic>? ?? map;
    return CryptoCoinDetails(
      info: coin ?? CryptoCoin.fromApi(info!),
      priceData: PriceData.fromApi(data),
      hourlyData: HourlyData.fromApi(data),
      dailyData: DailyData.fromApi(data),
      volumeData: VolumeData.fromApi(data),
      supplyData: SupplyData.fromApi(data),
    );
  }
}

class PriceData {
  final double price;
  final double open24h;
  final double change24h;
  final double changePct24h;
  final double high24h;
  final double low24h;

  PriceData({
    required this.price,
    required this.open24h,
    required this.change24h,
    required this.changePct24h,
    required this.high24h,
    required this.low24h,
  });

  factory PriceData.fromApi(Map<String, dynamic> json) {
    return PriceData(
      price: (json['PRICE'] as num).toDouble(),
      open24h: (json['OPEN24HOUR'] as num).toDouble(),
      change24h: (json['CHANGE24HOUR'] as num).toDouble(),
      changePct24h: (json['CHANGEPCT24HOUR'] as num).toDouble(),
      high24h: (json['HIGH24HOUR'] as num).toDouble(),
      low24h: (json['LOW24HOUR'] as num).toDouble(),
    );
  }

  PriceData copyWith({
    double? price,
    double? open24h,
    double? change24h,
    double? changePct24h,
    double? high24h,
    double? low24h,
  }) {
    return PriceData(
      price: price ?? this.price,
      open24h: open24h ?? this.open24h,
      change24h: change24h ?? this.change24h,
      changePct24h: changePct24h ?? this.changePct24h,
      high24h: high24h ?? this.high24h,
      low24h: low24h ?? this.low24h,
    );
  }
}

class DailyData {
  final double openDay;
  final double highDay;
  final double lowDay;
  final double changeDay;
  final double changePctDay;

  DailyData({
    required this.openDay,
    required this.highDay,
    required this.lowDay,
    required this.changeDay,
    required this.changePctDay,
  });

  factory DailyData.fromApi(Map<String, dynamic> json) {
    return DailyData(
      openDay: (json['OPENDAY'] as num).toDouble(),
      highDay: (json['HIGHDAY'] as num).toDouble(),
      lowDay: (json['LOWDAY'] as num).toDouble(),
      changeDay: (json['CHANGEDAY'] as num).toDouble(),
      changePctDay: (json['CHANGEPCTDAY'] as num).toDouble(),
    );
  }
}

class HourlyData {
  final double openHour;
  final double changeHour;
  final double changePctHour;
  final double highHour;
  final double lowHour;

  HourlyData({
    required this.openHour,
    required this.changeHour,
    required this.changePctHour,
    required this.highHour,
    required this.lowHour,
  });

  factory HourlyData.fromApi(Map<String, dynamic> json) {
    return HourlyData(
      openHour: (json['OPENHOUR'] as num).toDouble(),
      changeHour: (json['CHANGEHOUR'] as num).toDouble(),
      changePctHour: (json['CHANGEPCTHOUR'] as num).toDouble(),
      highHour: (json['HIGHHOUR'] as num).toDouble(),
      lowHour: (json['LOWHOUR'] as num).toDouble(),
    );
  }
}

class VolumeData {
  final double volumeHour;
  final double volume24h;
  final double topTierVolume24h;
  final double volumeDay;

  VolumeData({
    required this.volumeHour,
    required this.volume24h,
    required this.topTierVolume24h,
    required this.volumeDay,
  });

  factory VolumeData.fromApi(Map<String, dynamic> json) {
    return VolumeData(
      volumeHour: (json['VOLUMEHOURTO'] as num).toDouble(),
      volume24h: (json['TOTALVOLUME24HTO'] as num).toDouble(),
      topTierVolume24h: (json['TOTALTOPTIERVOLUME24HTO'] as num).toDouble(),
      volumeDay: (json['VOLUMEDAYTO'] as num).toDouble(),
    );
  }
}

class SupplyData {
  final int supply;
  final int circulatingSupply;
  final double marketCap;
  final double circulatingSupplyMarketCap;

  SupplyData({
    required this.supply,
    required this.circulatingSupply,
    required this.marketCap,
    required this.circulatingSupplyMarketCap,
  });

  factory SupplyData.fromApi(Map<String, dynamic> json) {
    return SupplyData(
      supply: (json['SUPPLY'] as num).toInt(),
      circulatingSupply: (json['CIRCULATINGSUPPLY'] as num).toInt(),
      marketCap: (json['MKTCAP'] as num).toDouble(),
      circulatingSupplyMarketCap: (json['CIRCULATINGSUPPLYMKTCAP'] as num)
          .toDouble(),
    );
  }
}

enum SortType { marketCap, price, change24h, volume24h }
