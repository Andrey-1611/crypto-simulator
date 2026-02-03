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
class BriefcaseRoute extends PageRouteInfo<BriefcaseRouteArgs> {
  BriefcaseRoute({Key? key, AppUser? user, List<PageRouteInfo>? children})
    : super(
        BriefcaseRoute.name,
        args: BriefcaseRouteArgs(key: key, user: user),
        initialChildren: children,
      );

  static const String name = 'BriefcaseRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BriefcaseRouteArgs>(
        orElse: () => const BriefcaseRouteArgs(),
      );
      return BriefcasePage(key: args.key, user: args.user);
    },
  );
}

class BriefcaseRouteArgs {
  const BriefcaseRouteArgs({this.key, this.user});

  final Key? key;

  final AppUser? user;

  @override
  String toString() {
    return 'BriefcaseRouteArgs{key: $key, user: $user}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! BriefcaseRouteArgs) return false;
    return key == other.key && user == other.user;
  }

  @override
  int get hashCode => key.hashCode ^ user.hashCode;
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
/// [EmailVerificationPage]
class EmailVerificationRoute extends PageRouteInfo<void> {
  const EmailVerificationRoute({List<PageRouteInfo>? children})
    : super(EmailVerificationRoute.name, initialChildren: children);

  static const String name = 'EmailVerificationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const EmailVerificationPage();
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
/// [ResetPasswordPage]
class ResetPasswordRoute extends PageRouteInfo<void> {
  const ResetPasswordRoute({List<PageRouteInfo>? children})
    : super(ResetPasswordRoute.name, initialChildren: children);

  static const String name = 'ResetPasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ResetPasswordPage();
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

/// generated route for
/// [SignInPage]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute({List<PageRouteInfo>? children})
    : super(SignInRoute.name, initialChildren: children);

  static const String name = 'SignInRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SignInPage();
    },
  );
}

/// generated route for
/// [SignUpPage]
class SignUpRoute extends PageRouteInfo<void> {
  const SignUpRoute({List<PageRouteInfo>? children})
    : super(SignUpRoute.name, initialChildren: children);

  static const String name = 'SignUpRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SignUpPage();
    },
  );
}

/// generated route for
/// [TradePage]
class TradeRoute extends PageRouteInfo<TradeRouteArgs> {
  TradeRoute({Key? key, required Trade trade, List<PageRouteInfo>? children})
    : super(
        TradeRoute.name,
        args: TradeRouteArgs(key: key, trade: trade),
        initialChildren: children,
      );

  static const String name = 'TradeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TradeRouteArgs>();
      return TradePage(key: args.key, trade: args.trade);
    },
  );
}

class TradeRouteArgs {
  const TradeRouteArgs({this.key, required this.trade});

  final Key? key;

  final Trade trade;

  @override
  String toString() {
    return 'TradeRouteArgs{key: $key, trade: $trade}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TradeRouteArgs) return false;
    return key == other.key && trade == other.trade;
  }

  @override
  int get hashCode => key.hashCode ^ trade.hashCode;
}
