// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser(
  id: json['id'] as String,
  name: json['name'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  balance: (json['balance'] as num).toDouble(),
  coins:
      (json['coins'] as List<dynamic>?)
          ?.map(
            (e) => _$recordConvert(
              e,
              ($jsonValue) => (
                amount: ($jsonValue['amount'] as num).toInt(),
                info: CryptoCoin.fromJson(
                  $jsonValue['info'] as Map<String, dynamic>,
                ),
              ),
            ),
          )
          .toList() ??
      const [],
  trades:
      (json['trades'] as List<dynamic>?)
          ?.map((e) => Trade.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'createdAt': instance.createdAt.toIso8601String(),
  'balance': instance.balance,
  'coins': instance.coins
      .map(
        (e) => <String, dynamic>{'amount': e.amount, 'info': e.info.toJson()},
      )
      .toList(),
  'trades': instance.trades.map((e) => e.toJson()).toList(),
};

$Rec _$recordConvert<$Rec>(Object? value, $Rec Function(Map) convert) =>
    convert(value as Map<String, dynamic>);
