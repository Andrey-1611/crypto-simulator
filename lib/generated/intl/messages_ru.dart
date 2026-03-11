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
      "${Intl.select(userExists, {'true': 'Нет сделок', 'other': 'У вас еще нет сделок'})}";

  static String m3(userExists) =>
      "${Intl.select(userExists, {'true': 'Нет монет', 'other': 'У вас еще нет монет'})}";

  static String m4(coinName) => "Продажа ${coinName}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "add": MessageLookupByLibrary.simpleMessage("Добавить"),
    "alreadyHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Уже есть аккаунт?  Войти в аккаунт",
    ),
    "amount": MessageLookupByLibrary.simpleMessage("Количество"),
    "apply": MessageLookupByLibrary.simpleMessage("Применить"),
    "avg_trade": MessageLookupByLibrary.simpleMessage("Средняя сделка"),
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
    "by_volume": MessageLookupByLibrary.simpleMessage("По объёму за 24ч"),
    "cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
    "change_24h": MessageLookupByLibrary.simpleMessage("Изменение 24ч"),
    "change_24h_pct": MessageLookupByLibrary.simpleMessage("Изменение % 24ч"),
    "change_pct": MessageLookupByLibrary.simpleMessage("Изменение в %"),
    "check": MessageLookupByLibrary.simpleMessage("Проверить"),
    "circulating_supply": MessageLookupByLibrary.simpleMessage("В обращении"),
    "circulating_supply_cap": MessageLookupByLibrary.simpleMessage(
      "Капитализация в обращении",
    ),
    "coin": MessageLookupByLibrary.simpleMessage("Монета"),
    "coin_amount": MessageLookupByLibrary.simpleMessage("Количество монет"),
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
    "compare": MessageLookupByLibrary.simpleMessage("Сравнение"),
    "compare_coins": MessageLookupByLibrary.simpleMessage("Сравнение монет"),
    "confirm": MessageLookupByLibrary.simpleMessage("Подтвердить"),
    "created": MessageLookupByLibrary.simpleMessage("Создан"),
    "current_indicators": MessageLookupByLibrary.simpleMessage(
      "Текущие показатели",
    ),
    "current_price": MessageLookupByLibrary.simpleMessage("Текущая цена"),
    "current_total_price": MessageLookupByLibrary.simpleMessage(
      "Текущая общая цена",
    ),
    "daily_data": MessageLookupByLibrary.simpleMessage("Данные за день"),
    "dark_theme": MessageLookupByLibrary.simpleMessage("Темная тема"),
    "data": MessageLookupByLibrary.simpleMessage("Данные"),
    "date": MessageLookupByLibrary.simpleMessage("Дата"),
    "day_change": MessageLookupByLibrary.simpleMessage("Изменение за день"),
    "day_change_pct": MessageLookupByLibrary.simpleMessage(
      "Изменение % за день",
    ),
    "email": MessageLookupByLibrary.simpleMessage("Почта"),
    "emailSent": MessageLookupByLibrary.simpleMessage(
      "Пиcьмо отправлено на вашу почту",
    ),
    "emailVerification": MessageLookupByLibrary.simpleMessage(
      "Подтверждение почты",
    ),
    "empty_trades": m2,
    "english_language": MessageLookupByLibrary.simpleMessage("Английский язык"),
    "favourite": MessageLookupByLibrary.simpleMessage("Избранное"),
    "filters": MessageLookupByLibrary.simpleMessage("Фильтры"),
    "first_trade": MessageLookupByLibrary.simpleMessage("Первая сделка"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Забыли пароль? Сбросить пароль",
    ),
    "high_24h": MessageLookupByLibrary.simpleMessage("Максимум 24ч"),
    "high_day": MessageLookupByLibrary.simpleMessage("Максимум за день"),
    "highest_amount": MessageLookupByLibrary.simpleMessage(
      "Сначала больше монет",
    ),
    "highest_total": MessageLookupByLibrary.simpleMessage(
      "Сначала большие суммы",
    ),
    "history": MessageLookupByLibrary.simpleMessage("История"),
    "hour_change": MessageLookupByLibrary.simpleMessage("Изменение за час"),
    "hour_change_pct": MessageLookupByLibrary.simpleMessage(
      "Изменение % за час",
    ),
    "hour_high": MessageLookupByLibrary.simpleMessage("Максимум за час"),
    "hour_low": MessageLookupByLibrary.simpleMessage("Минимум за час"),
    "hourly_data": MessageLookupByLibrary.simpleMessage("Данные за час"),
    "id": MessageLookupByLibrary.simpleMessage("ID"),
    "information": MessageLookupByLibrary.simpleMessage("Информация"),
    "largest_trade": MessageLookupByLibrary.simpleMessage("Крупнейшая сделка"),
    "last_trade": MessageLookupByLibrary.simpleMessage("Последняя сделка"),
    "loading": MessageLookupByLibrary.simpleMessage("Загрузка..."),
    "low_24h": MessageLookupByLibrary.simpleMessage("Минимум 24ч"),
    "low_day": MessageLookupByLibrary.simpleMessage("Минимум за день"),
    "lowest_amount": MessageLookupByLibrary.simpleMessage(
      "Сначала меньше монет",
    ),
    "lowest_total": MessageLookupByLibrary.simpleMessage(
      "Сначала маленькие суммы",
    ),
    "market": MessageLookupByLibrary.simpleMessage("Биржа"),
    "market_cap": MessageLookupByLibrary.simpleMessage("Капитализация"),
    "market_data": MessageLookupByLibrary.simpleMessage("Рыночные данные"),
    "name": MessageLookupByLibrary.simpleMessage("Имя"),
    "newest_first": MessageLookupByLibrary.simpleMessage("Сначала новые"),
    "noAccount": MessageLookupByLibrary.simpleMessage(
      "Еще нет аккаунта?  Создать аккаунт",
    ),
    "no_coins": m3,
    "no_coins_found": MessageLookupByLibrary.simpleMessage("Монет не найдено"),
    "no_favourite_coins": MessageLookupByLibrary.simpleMessage(
      "У вас нет избранных монет",
    ),
    "no_internet_connection": MessageLookupByLibrary.simpleMessage(
      "Нет подключения к интернету",
    ),
    "no_operations_found": MessageLookupByLibrary.simpleMessage(
      "Сделок не найдено",
    ),
    "num_coin_types": MessageLookupByLibrary.simpleMessage(
      "Количество типов монет",
    ),
    "num_coins": MessageLookupByLibrary.simpleMessage("Количество монет"),
    "num_coins_purchased": MessageLookupByLibrary.simpleMessage(
      "Куплено монет",
    ),
    "num_coins_purchased_24h": MessageLookupByLibrary.simpleMessage(
      "Куплено монет за 24 часа",
    ),
    "num_coins_purchased_7d": MessageLookupByLibrary.simpleMessage(
      "Куплено монет за 7 дней",
    ),
    "num_transactions": MessageLookupByLibrary.simpleMessage(
      "Количество сделок",
    ),
    "oldest_first": MessageLookupByLibrary.simpleMessage("Сначала старые"),
    "open_24h": MessageLookupByLibrary.simpleMessage("Открытие за 24ч"),
    "open_day": MessageLookupByLibrary.simpleMessage("Открытие дня"),
    "open_hour": MessageLookupByLibrary.simpleMessage("Открытие часа"),
    "password": MessageLookupByLibrary.simpleMessage("Пароль"),
    "perform": MessageLookupByLibrary.simpleMessage("Совершить"),
    "price": MessageLookupByLibrary.simpleMessage("Текущая цена"),
    "price_p": MessageLookupByLibrary.simpleMessage("Цена"),
    "profit": MessageLookupByLibrary.simpleMessage("Прибыль"),
    "profit_percent": MessageLookupByLibrary.simpleMessage("Прибыль в %"),
    "rate": MessageLookupByLibrary.simpleMessage("Оценить"),
    "rating": MessageLookupByLibrary.simpleMessage("Рейтинг"),
    "resend": MessageLookupByLibrary.simpleMessage("Отправить повторно"),
    "reset": MessageLookupByLibrary.simpleMessage("Сбросить"),
    "resetPassword": MessageLookupByLibrary.simpleMessage("Сброс пароля"),
    "reset_search": MessageLookupByLibrary.simpleMessage("Сбросить поиск"),
    "search": MessageLookupByLibrary.simpleMessage("Найти"),
    "search_coin": MessageLookupByLibrary.simpleMessage("Поиск монеты"),
    "search_coins": MessageLookupByLibrary.simpleMessage("Поиск монет"),
    "search_hint": MessageLookupByLibrary.simpleMessage("Поиск..."),
    "searching": MessageLookupByLibrary.simpleMessage("Поиск"),
    "select_period": MessageLookupByLibrary.simpleMessage("Выбрать период"),
    "sell": MessageLookupByLibrary.simpleMessage("Продать"),
    "sell_coin_a": m4,
    "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
    "signIn": MessageLookupByLibrary.simpleMessage("Войти"),
    "signOutConfirm": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите выйти из акканта?",
    ),
    "signUp": MessageLookupByLibrary.simpleMessage("Зарегистрироваться"),
    "sort": MessageLookupByLibrary.simpleMessage("Сортировка"),
    "sorting": MessageLookupByLibrary.simpleMessage("Сортировка"),
    "spent_24h": MessageLookupByLibrary.simpleMessage("Потрачено за 24 часа"),
    "spent_7d": MessageLookupByLibrary.simpleMessage(
      "Всего потрачено за 7 дней",
    ),
    "start_searching_coins": MessageLookupByLibrary.simpleMessage(
      "Начните искать монеты",
    ),
    "success": MessageLookupByLibrary.simpleMessage("Успешно!"),
    "supply": MessageLookupByLibrary.simpleMessage("Всего монет"),
    "supply_data": MessageLookupByLibrary.simpleMessage("Данные о монетах"),
    "symbol": MessageLookupByLibrary.simpleMessage("Символ"),
    "test": MessageLookupByLibrary.simpleMessage(""),
    "top_tier_volume_24h": MessageLookupByLibrary.simpleMessage(
      "Объем топ-бирж за 24ч",
    ),
    "total_balance": MessageLookupByLibrary.simpleMessage("Общий баланс"),
    "total_price": MessageLookupByLibrary.simpleMessage("Общая цена"),
    "total_spent": MessageLookupByLibrary.simpleMessage("Всего потрачено"),
    "trade": MessageLookupByLibrary.simpleMessage("Сделка"),
    "trade_details": MessageLookupByLibrary.simpleMessage("Детали сделки"),
    "trades": MessageLookupByLibrary.simpleMessage("Сделки"),
    "trades_24h": MessageLookupByLibrary.simpleMessage(
      "Количество сделок за 24 часа",
    ),
    "trades_7d": MessageLookupByLibrary.simpleMessage(
      "Количество сделок за 7 дней",
    ),
    "transaction_info": MessageLookupByLibrary.simpleMessage(
      "Данных о сделках",
    ),
    "try_again": MessageLookupByLibrary.simpleMessage("Попробовать еще раз"),
    "type": MessageLookupByLibrary.simpleMessage("Тип"),
    "unknown_error": MessageLookupByLibrary.simpleMessage("Неизвестная ошибка"),
    "unknown_error_try_again": MessageLookupByLibrary.simpleMessage(
      "Неизвестная ошибка, попробуйте еще раз",
    ),
    "user_data": MessageLookupByLibrary.simpleMessage("Данные о пользователе"),
    "volume_24h": MessageLookupByLibrary.simpleMessage("Объем за 24ч"),
    "volume_data": MessageLookupByLibrary.simpleMessage("Данные объёма"),
    "volume_day": MessageLookupByLibrary.simpleMessage("Объём за день"),
    "volume_hour": MessageLookupByLibrary.simpleMessage("Объем за час"),
  };
}
