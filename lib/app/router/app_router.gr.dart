// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [BriefcasePage]
class BriefcaseRoute extends PageRouteInfo<void> {
  const BriefcaseRoute({List<PageRouteInfo>? children})
    : super(BriefcaseRoute.name, initialChildren: children);

  static const String name = 'BriefcaseRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const BriefcasePage();
    },
  );
}

/// generated route for
/// [CryptoCoinPage]
class CryptoCoinRoute extends PageRouteInfo<CryptoCoinRouteArgs> {
  CryptoCoinRoute({
    Key? key,
    required CryptoCoin coin,
    List<PageRouteInfo>? children,
  }) : super(
         CryptoCoinRoute.name,
         args: CryptoCoinRouteArgs(key: key, coin: coin),
         initialChildren: children,
       );

  static const String name = 'CryptoCoinRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CryptoCoinRouteArgs>();
      return CryptoCoinPage(key: args.key, coin: args.coin);
    },
  );
}

class CryptoCoinRouteArgs {
  const CryptoCoinRouteArgs({this.key, required this.coin});

  final Key? key;

  final CryptoCoin coin;

  @override
  String toString() {
    return 'CryptoCoinRouteArgs{key: $key, coin: $coin}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CryptoCoinRouteArgs) return false;
    return key == other.key && coin == other.coin;
  }

  @override
  int get hashCode => key.hashCode ^ coin.hashCode;
}

/// generated route for
/// [FavouritePage]
class FavouriteRoute extends PageRouteInfo<void> {
  const FavouriteRoute({List<PageRouteInfo>? children})
    : super(FavouriteRoute.name, initialChildren: children);

  static const String name = 'FavouriteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FavouritePage();
    },
  );
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [MarketPage]
class MarketRoute extends PageRouteInfo<void> {
  const MarketRoute({List<PageRouteInfo>? children})
    : super(MarketRoute.name, initialChildren: children);

  static const String name = 'MarketRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MarketPage();
    },
  );
}

/// generated route for
/// [RatingPage]
class RatingRoute extends PageRouteInfo<void> {
  const RatingRoute({List<PageRouteInfo>? children})
    : super(RatingRoute.name, initialChildren: children);

  static const String name = 'RatingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RatingPage();
    },
  );
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsPage();
    },
  );
}
