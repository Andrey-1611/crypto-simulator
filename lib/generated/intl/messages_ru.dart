// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static String m0(coinName) => "Покупка ${coinName}";

  static String m1(amount) =>
      "${Intl.plural(amount, one: '1 монета', few: '${amount} монеты', other: '${amount} монет')}";

  static String m2(userExists) =>
      "${Intl.select(userExists, {'true': 'Нет операций', 'other': 'У вас еще нет операций'})}";

  static String m3(userExists) =>
      "${Intl.select(userExists, {'true': 'Нет монет', 'other': 'У вас еще нет монет'})}";

  static String m4(coinName) => "Продажа ${coinName}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "amount": MessageLookupByLibrary.simpleMessage("Количество"),
    "balance": MessageLookupByLibrary.simpleMessage("Баланс"),
    "balance_error": MessageLookupByLibrary.simpleMessage(
      "На балансе недостаточно средств!",
    ),
    "balance_info": MessageLookupByLibrary.simpleMessage("Данные о балансе"),
    "briefcase": MessageLookupByLibrary.simpleMessage("Портфель"),
    "buy": MessageLookupByLibrary.simpleMessage("Купить"),
    "buy_coin": m0,
    "by_change_24h": MessageLookupByLibrary.simpleMessage("Изменение за 24ч"),
    "by_market_cap": MessageLookupByLibrary.simpleMessage("По капитализации"),
    "by_price": MessageLookupByLibrary.simpleMessage("По цене"),
    "by_volume": MessageLookupByLibrary.simpleMessage("По объёму"),
    "circulating_supply": MessageLookupByLibrary.simpleMessage("В обращении"),
    "coin": MessageLookupByLibrary.simpleMessage("Монета"),
    "coin_balance": MessageLookupByLibrary.simpleMessage("Баланс в монетах"),
    "coin_id": MessageLookupByLibrary.simpleMessage("ID монеты"),
    "coin_info": MessageLookupByLibrary.simpleMessage("Данные о монетах"),
    "coin_price": MessageLookupByLibrary.simpleMessage("Цена монеты"),
    "coins": MessageLookupByLibrary.simpleMessage("Монеты"),
    "coins_a": m1,
    "coins_amount_error": MessageLookupByLibrary.simpleMessage(
      "У вас нет необходимого количества монет!",
    ),
    "coins_balance": MessageLookupByLibrary.simpleMessage(
      "Количество монет на балансе",
    ),
    "coins_not_found": MessageLookupByLibrary.simpleMessage("Монет не найдено"),
    "confirm": MessageLookupByLibrary.simpleMessage("Подтвердить"),
    "created": MessageLookupByLibrary.simpleMessage("Создан"),
    "dark_theme": MessageLookupByLibrary.simpleMessage("Темная тема"),
    "data": MessageLookupByLibrary.simpleMessage("Данные"),
    "date": MessageLookupByLibrary.simpleMessage("Дата"),
    "email": MessageLookupByLibrary.simpleMessage("Почта"),
    "empty_trades": m2,
    "english_language": MessageLookupByLibrary.simpleMessage("Английский язык"),
    "favourite": MessageLookupByLibrary.simpleMessage("Избранное"),
    "high_24h": MessageLookupByLibrary.simpleMessage("Максимум (24ч)"),
    "id": MessageLookupByLibrary.simpleMessage("ID"),
    "information": MessageLookupByLibrary.simpleMessage("Информация"),
    "low_24h": MessageLookupByLibrary.simpleMessage("Минимум (24ч)"),
    "market": MessageLookupByLibrary.simpleMessage("Биржа"),
    "market_cap": MessageLookupByLibrary.simpleMessage("Капитализация"),
    "name": MessageLookupByLibrary.simpleMessage("Имя"),
    "no_coins": m3,
    "num_coin_types": MessageLookupByLibrary.simpleMessage(
      "Количество типов монет",
    ),
    "num_coins": MessageLookupByLibrary.simpleMessage("Количество монет"),
    "num_coins_purchased": MessageLookupByLibrary.simpleMessage(
      "Количество купленых монет",
    ),
    "num_transactions": MessageLookupByLibrary.simpleMessage(
      "Количество операций",
    ),
    "perform": MessageLookupByLibrary.simpleMessage("Совершить"),
    "rating": MessageLookupByLibrary.simpleMessage("Рейтинг"),
    "reset_search": MessageLookupByLibrary.simpleMessage("Сбросить поиск"),
    "search_hint": MessageLookupByLibrary.simpleMessage("Поиск..."),
    "sell": MessageLookupByLibrary.simpleMessage("Продать"),
    "sell_coin_a": m4,
    "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
    "sort": MessageLookupByLibrary.simpleMessage("Сортировка"),
    "success": MessageLookupByLibrary.simpleMessage("Успешно!"),
    "test": MessageLookupByLibrary.simpleMessage(""),
    "total_balance": MessageLookupByLibrary.simpleMessage("Общий баланс"),
    "total_price": MessageLookupByLibrary.simpleMessage("Общая цена"),
    "total_spent": MessageLookupByLibrary.simpleMessage("Всего потрачено"),
    "trade": MessageLookupByLibrary.simpleMessage("Сделка"),
    "trade_details": MessageLookupByLibrary.simpleMessage("Детали сделаки"),
    "trades": MessageLookupByLibrary.simpleMessage("Операции"),
    "transaction_info": MessageLookupByLibrary.simpleMessage(
      "Данных об операциях",
    ),
    "try_again": MessageLookupByLibrary.simpleMessage("Попробовать еще раз"),
    "type": MessageLookupByLibrary.simpleMessage("Тип"),
    "unknown_error": MessageLookupByLibrary.simpleMessage("Неизвестная ошибка"),
    "user_data": MessageLookupByLibrary.simpleMessage("Данные о пользователе"),
    "volume_24h": MessageLookupByLibrary.simpleMessage("Объем (24ч)"),
  };
}
