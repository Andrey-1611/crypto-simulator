// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(coinName) => "Buy ${coinName}";

  static String m1(amount) =>
      "${Intl.plural(amount, one: '1 coin', other: '${amount} coins')}";

  static String m2(userExists) =>
      "${Intl.select(userExists, {'true': 'You have no trades yet', 'other': 'You don\'t have any trades yet'})}";

  static String m3(userExists) =>
      "${Intl.select(userExists, {'true': 'You have no coins yet', 'other': 'You don\'t have any coins yet'})}";

  static String m4(coinName) => "Sell ${coinName}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "alreadyHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Already have an account? Sign in",
    ),
    "amount": MessageLookupByLibrary.simpleMessage("Amount"),
    "apply": MessageLookupByLibrary.simpleMessage("Apply"),
    "balance": MessageLookupByLibrary.simpleMessage("Balance"),
    "balance_error": MessageLookupByLibrary.simpleMessage(
      "Insufficient balance!",
    ),
    "balance_info": MessageLookupByLibrary.simpleMessage("Balance Information"),
    "briefcase": MessageLookupByLibrary.simpleMessage("Briefcase"),
    "buy": MessageLookupByLibrary.simpleMessage("Buy"),
    "buy_coin": m0,
    "by_change_24h": MessageLookupByLibrary.simpleMessage("24h change"),
    "by_market_cap": MessageLookupByLibrary.simpleMessage(
      "By market capitalization",
    ),
    "by_price": MessageLookupByLibrary.simpleMessage("By price"),
    "by_volume": MessageLookupByLibrary.simpleMessage("24h volume"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "change_24h": MessageLookupByLibrary.simpleMessage("24h Change"),
    "change_24h_pct": MessageLookupByLibrary.simpleMessage("24h Change %"),
    "check": MessageLookupByLibrary.simpleMessage("Check"),
    "circulating_supply": MessageLookupByLibrary.simpleMessage(
      "Circulating supply",
    ),
    "circulating_supply_cap": MessageLookupByLibrary.simpleMessage(
      "Circulating Supply Market Cap",
    ),
    "coin": MessageLookupByLibrary.simpleMessage("Coin"),
    "coin_amount": MessageLookupByLibrary.simpleMessage("Coin amount"),
    "coin_balance": MessageLookupByLibrary.simpleMessage("Coin Balance"),
    "coin_id": MessageLookupByLibrary.simpleMessage("Coin ID"),
    "coin_info": MessageLookupByLibrary.simpleMessage("Coin Information"),
    "coin_price": MessageLookupByLibrary.simpleMessage("Coin Price"),
    "coins": MessageLookupByLibrary.simpleMessage("Coins"),
    "coins_a": m1,
    "coins_amount_error": MessageLookupByLibrary.simpleMessage(
      "You don\'t have enough coins!",
    ),
    "coins_balance": MessageLookupByLibrary.simpleMessage(
      "Number of coins on the balance",
    ),
    "coins_not_found": MessageLookupByLibrary.simpleMessage("No coins found"),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "created": MessageLookupByLibrary.simpleMessage("Created"),
    "daily_data": MessageLookupByLibrary.simpleMessage("Daily Data"),
    "dark_theme": MessageLookupByLibrary.simpleMessage("Dark Theme"),
    "data": MessageLookupByLibrary.simpleMessage("Data"),
    "data_section": MessageLookupByLibrary.simpleMessage("Data"),
    "date": MessageLookupByLibrary.simpleMessage("Date"),
    "day_change": MessageLookupByLibrary.simpleMessage("Day Change"),
    "day_change_pct": MessageLookupByLibrary.simpleMessage("Day Change %"),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "emailSent": MessageLookupByLibrary.simpleMessage(
      "Email sent to your inbox",
    ),
    "emailVerification": MessageLookupByLibrary.simpleMessage(
      "Email Verification",
    ),
    "empty_trades": m2,
    "english_language": MessageLookupByLibrary.simpleMessage(
      "English Language",
    ),
    "favourite": MessageLookupByLibrary.simpleMessage("Favourite"),
    "filters": MessageLookupByLibrary.simpleMessage("Filters"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Forgot password? Reset password",
    ),
    "high_24h": MessageLookupByLibrary.simpleMessage("High (24h)"),
    "high_day": MessageLookupByLibrary.simpleMessage("High Day"),
    "highest_amount": MessageLookupByLibrary.simpleMessage(
      "Highest amount first",
    ),
    "highest_total": MessageLookupByLibrary.simpleMessage(
      "Highest total first",
    ),
    "history": MessageLookupByLibrary.simpleMessage("History"),
    "hour_change": MessageLookupByLibrary.simpleMessage("Hour Change"),
    "hour_change_pct": MessageLookupByLibrary.simpleMessage("Hour Change %"),
    "hour_high": MessageLookupByLibrary.simpleMessage("Hour High"),
    "hour_low": MessageLookupByLibrary.simpleMessage("Hour Low"),
    "hourly_data": MessageLookupByLibrary.simpleMessage("Hourly Data"),
    "id": MessageLookupByLibrary.simpleMessage("ID"),
    "information": MessageLookupByLibrary.simpleMessage("Information"),
    "loading": MessageLookupByLibrary.simpleMessage("Loading..."),
    "low_24h": MessageLookupByLibrary.simpleMessage("Low (24h)"),
    "low_day": MessageLookupByLibrary.simpleMessage("Low Day"),
    "lowest_amount": MessageLookupByLibrary.simpleMessage(
      "Lowest amount first",
    ),
    "lowest_total": MessageLookupByLibrary.simpleMessage("Lowest total first"),
    "market": MessageLookupByLibrary.simpleMessage("Market"),
    "market_cap": MessageLookupByLibrary.simpleMessage("Market capitalization"),
    "market_data": MessageLookupByLibrary.simpleMessage("Market Data"),
    "name": MessageLookupByLibrary.simpleMessage("Name"),
    "newest_first": MessageLookupByLibrary.simpleMessage("Newest first"),
    "noAccount": MessageLookupByLibrary.simpleMessage(
      "Don’t have an account? Create one",
    ),
    "no_coins": m3,
    "no_coins_found": MessageLookupByLibrary.simpleMessage("No coins found"),
    "no_favourite_coins": MessageLookupByLibrary.simpleMessage(
      "You have no favourite coins",
    ),
    "no_operations_found": MessageLookupByLibrary.simpleMessage(
      "No operations found",
    ),
    "num_coin_types": MessageLookupByLibrary.simpleMessage(
      "Number of Coin Types",
    ),
    "num_coins": MessageLookupByLibrary.simpleMessage("Number of Coins"),
    "num_coins_purchased": MessageLookupByLibrary.simpleMessage(
      "Number of Coins Purchased",
    ),
    "num_transactions": MessageLookupByLibrary.simpleMessage(
      "Number of Transactions",
    ),
    "oldest_first": MessageLookupByLibrary.simpleMessage("Oldest first"),
    "open_24h": MessageLookupByLibrary.simpleMessage("Open 24h"),
    "open_day": MessageLookupByLibrary.simpleMessage("Open Day"),
    "open_hour": MessageLookupByLibrary.simpleMessage("Open Hour"),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "perform": MessageLookupByLibrary.simpleMessage("Perform"),
    "price": MessageLookupByLibrary.simpleMessage("Current Price"),
    "rating": MessageLookupByLibrary.simpleMessage("Rating"),
    "resend": MessageLookupByLibrary.simpleMessage("Resend"),
    "reset": MessageLookupByLibrary.simpleMessage("Reset"),
    "resetPassword": MessageLookupByLibrary.simpleMessage("Reset password"),
    "reset_search": MessageLookupByLibrary.simpleMessage("Reset search"),
    "search_coin": MessageLookupByLibrary.simpleMessage("Search coin"),
    "search_coins": MessageLookupByLibrary.simpleMessage("Search Coins"),
    "search_hint": MessageLookupByLibrary.simpleMessage("Search..."),
    "select_period": MessageLookupByLibrary.simpleMessage("Select period"),
    "sell": MessageLookupByLibrary.simpleMessage("Sell"),
    "sell_coin_a": m4,
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "signIn": MessageLookupByLibrary.simpleMessage("Sign In"),
    "signOutConfirm": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to sign out?",
    ),
    "signUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
    "sort": MessageLookupByLibrary.simpleMessage("Sorting"),
    "sorting": MessageLookupByLibrary.simpleMessage("Sorting"),
    "start_searching_coins": MessageLookupByLibrary.simpleMessage(
      "Start searching coins",
    ),
    "success": MessageLookupByLibrary.simpleMessage("Success!"),
    "supply": MessageLookupByLibrary.simpleMessage("Supply"),
    "supply_data": MessageLookupByLibrary.simpleMessage("Supply Data"),
    "symbol": MessageLookupByLibrary.simpleMessage("Symbol"),
    "test": MessageLookupByLibrary.simpleMessage(""),
    "top_tier_volume_24h": MessageLookupByLibrary.simpleMessage(
      "Top Tier Volume 24h",
    ),
    "total_balance": MessageLookupByLibrary.simpleMessage("Total Balance"),
    "total_price": MessageLookupByLibrary.simpleMessage("Total Price"),
    "total_spent": MessageLookupByLibrary.simpleMessage("Total Spent"),
    "trade": MessageLookupByLibrary.simpleMessage("Trade"),
    "trade_details": MessageLookupByLibrary.simpleMessage("Trade Details"),
    "trades": MessageLookupByLibrary.simpleMessage("Trades"),
    "transaction_info": MessageLookupByLibrary.simpleMessage(
      "Transaction Information",
    ),
    "try_again": MessageLookupByLibrary.simpleMessage("Try again"),
    "type": MessageLookupByLibrary.simpleMessage("Type"),
    "unknown_error": MessageLookupByLibrary.simpleMessage("Unknown error"),
    "unknown_error_try_again": MessageLookupByLibrary.simpleMessage(
      "Unknown error, try again",
    ),
    "user_data": MessageLookupByLibrary.simpleMessage("User Information"),
    "volume_24h": MessageLookupByLibrary.simpleMessage("Volume (24h)"),
    "volume_data": MessageLookupByLibrary.simpleMessage("Volume Data"),
    "volume_day": MessageLookupByLibrary.simpleMessage("Volume Day"),
    "volume_hour": MessageLookupByLibrary.simpleMessage("Volume Hour"),
  };
}
