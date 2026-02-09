// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Market`
  String get market {
    return Intl.message('Market', name: 'market', desc: '', args: []);
  }

  /// `Briefcase`
  String get briefcase {
    return Intl.message('Briefcase', name: 'briefcase', desc: '', args: []);
  }

  /// `Favourite`
  String get favourite {
    return Intl.message('Favourite', name: 'favourite', desc: '', args: []);
  }

  /// `Rating`
  String get rating {
    return Intl.message('Rating', name: 'rating', desc: '', args: []);
  }

  /// `Balance Information`
  String get balance_info {
    return Intl.message(
      'Balance Information',
      name: 'balance_info',
      desc: '',
      args: [],
    );
  }

  /// `Balance`
  String get balance {
    return Intl.message('Balance', name: 'balance', desc: '', args: []);
  }

  /// `Coin Balance`
  String get coin_balance {
    return Intl.message(
      'Coin Balance',
      name: 'coin_balance',
      desc: '',
      args: [],
    );
  }

  /// `Total Balance`
  String get total_balance {
    return Intl.message(
      'Total Balance',
      name: 'total_balance',
      desc: '',
      args: [],
    );
  }

  /// `Transaction Information`
  String get transaction_info {
    return Intl.message(
      'Transaction Information',
      name: 'transaction_info',
      desc: '',
      args: [],
    );
  }

  /// `Number of Transactions`
  String get num_transactions {
    return Intl.message(
      'Number of Transactions',
      name: 'num_transactions',
      desc: '',
      args: [],
    );
  }

  /// `Total Spent`
  String get total_spent {
    return Intl.message('Total Spent', name: 'total_spent', desc: '', args: []);
  }

  /// `Coin Information`
  String get coin_info {
    return Intl.message(
      'Coin Information',
      name: 'coin_info',
      desc: '',
      args: [],
    );
  }

  /// `Number of Coin Types`
  String get num_coin_types {
    return Intl.message(
      'Number of Coin Types',
      name: 'num_coin_types',
      desc: '',
      args: [],
    );
  }

  /// `Number of Coins Purchased`
  String get num_coins_purchased {
    return Intl.message(
      'Number of Coins Purchased',
      name: 'num_coins_purchased',
      desc: '',
      args: [],
    );
  }

  /// `Number of Coins`
  String get num_coins {
    return Intl.message(
      'Number of Coins',
      name: 'num_coins',
      desc: '',
      args: [],
    );
  }

  /// `Coins`
  String get coins {
    return Intl.message('Coins', name: 'coins', desc: '', args: []);
  }

  /// `Trades`
  String get trades {
    return Intl.message('Trades', name: 'trades', desc: '', args: []);
  }

  /// `Buy`
  String get buy {
    return Intl.message('Buy', name: 'buy', desc: '', args: []);
  }

  /// `{userExists, select, true {You have no coins yet} other {You don't have any coins yet}}`
  String no_coins(Object userExists) {
    return Intl.select(
      userExists,
      {
        'true': 'You have no coins yet',
        'other': 'You don\'t have any coins yet',
      },
      name: 'no_coins',
      desc: '',
      args: [userExists],
    );
  }

  /// `{amount, plural, =1 {1 coin} other {{amount} coins}}`
  String coins_a(num amount) {
    return Intl.plural(
      amount,
      one: '1 coin',
      other: '$amount coins',
      name: 'coins_a',
      desc: '',
      args: [amount],
    );
  }

  /// `Trade Details`
  String get trade_details {
    return Intl.message(
      'Trade Details',
      name: 'trade_details',
      desc: '',
      args: [],
    );
  }

  /// `Data`
  String get data_section {
    return Intl.message('Data', name: 'data_section', desc: '', args: []);
  }

  /// `Type`
  String get type {
    return Intl.message('Type', name: 'type', desc: '', args: []);
  }

  /// `Amount`
  String get amount {
    return Intl.message('Amount', name: 'amount', desc: '', args: []);
  }

  /// `Coin`
  String get coin {
    return Intl.message('Coin', name: 'coin', desc: '', args: []);
  }

  /// `Coin ID`
  String get coin_id {
    return Intl.message('Coin ID', name: 'coin_id', desc: '', args: []);
  }

  /// `Coin Price`
  String get coin_price {
    return Intl.message('Coin Price', name: 'coin_price', desc: '', args: []);
  }

  /// `Total Price`
  String get total_price {
    return Intl.message('Total Price', name: 'total_price', desc: '', args: []);
  }

  /// `Date`
  String get date {
    return Intl.message('Date', name: 'date', desc: '', args: []);
  }

  /// `Data`
  String get data {
    return Intl.message('Data', name: 'data', desc: '', args: []);
  }

  /// `{userExists, select, true {You have no trades yet} other {You don't have any trades yet}}`
  String empty_trades(Object userExists) {
    return Intl.select(
      userExists,
      {
        'true': 'You have no trades yet',
        'other': 'You don\'t have any trades yet',
      },
      name: 'empty_trades',
      desc: '',
      args: [userExists],
    );
  }

  /// `Perform`
  String get perform {
    return Intl.message('Perform', name: 'perform', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `User Information`
  String get user_data {
    return Intl.message(
      'User Information',
      name: 'user_data',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Created`
  String get created {
    return Intl.message('Created', name: 'created', desc: '', args: []);
  }

  /// `Dark Theme`
  String get dark_theme {
    return Intl.message('Dark Theme', name: 'dark_theme', desc: '', args: []);
  }

  /// `English Language`
  String get english_language {
    return Intl.message(
      'English Language',
      name: 'english_language',
      desc: '',
      args: [],
    );
  }

  /// `Trade`
  String get trade {
    return Intl.message('Trade', name: 'trade', desc: '', args: []);
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Buy {coinName}`
  String buy_coin(Object coinName) {
    return Intl.message(
      'Buy $coinName',
      name: 'buy_coin',
      desc: '',
      args: [coinName],
    );
  }

  /// `Sorting`
  String get sort {
    return Intl.message('Sorting', name: 'sort', desc: '', args: []);
  }

  /// `By market capitalization`
  String get by_market_cap {
    return Intl.message(
      'By market capitalization',
      name: 'by_market_cap',
      desc: '',
      args: [],
    );
  }

  /// `By price`
  String get by_price {
    return Intl.message('By price', name: 'by_price', desc: '', args: []);
  }

  /// `24h change`
  String get by_change_24h {
    return Intl.message(
      '24h change',
      name: 'by_change_24h',
      desc: '',
      args: [],
    );
  }

  /// `By volume`
  String get by_volume {
    return Intl.message('By volume', name: 'by_volume', desc: '', args: []);
  }

  /// `Sell {coinName}`
  String sell_coin_a(Object coinName) {
    return Intl.message(
      'Sell $coinName',
      name: 'sell_coin_a',
      desc: '',
      args: [coinName],
    );
  }

  /// `Number of coins on the balance`
  String get coins_balance {
    return Intl.message(
      'Number of coins on the balance',
      name: 'coins_balance',
      desc: '',
      args: [],
    );
  }

  /// `Symbol`
  String get symbol {
    return Intl.message('Symbol', name: 'symbol', desc: '', args: []);
  }

  /// `ID`
  String get id {
    return Intl.message('ID', name: 'id', desc: '', args: []);
  }

  /// `Sell`
  String get sell {
    return Intl.message('Sell', name: 'sell', desc: '', args: []);
  }

  /// ``
  String get test {
    return Intl.message('', name: 'test', desc: '', args: []);
  }

  /// `Market capitalization`
  String get market_cap {
    return Intl.message(
      'Market capitalization',
      name: 'market_cap',
      desc: '',
      args: [],
    );
  }

  /// `Volume (24h)`
  String get volume_24h {
    return Intl.message('Volume (24h)', name: 'volume_24h', desc: '', args: []);
  }

  /// `Circulating supply`
  String get circulating_supply {
    return Intl.message(
      'Circulating supply',
      name: 'circulating_supply',
      desc: '',
      args: [],
    );
  }

  /// `High (24h)`
  String get high_24h {
    return Intl.message('High (24h)', name: 'high_24h', desc: '', args: []);
  }

  /// `Low (24h)`
  String get low_24h {
    return Intl.message('Low (24h)', name: 'low_24h', desc: '', args: []);
  }

  /// `Information`
  String get information {
    return Intl.message('Information', name: 'information', desc: '', args: []);
  }

  /// `No coins found`
  String get coins_not_found {
    return Intl.message(
      'No coins found',
      name: 'coins_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Reset search`
  String get reset_search {
    return Intl.message(
      'Reset search',
      name: 'reset_search',
      desc: '',
      args: [],
    );
  }

  /// `Search...`
  String get search_hint {
    return Intl.message('Search...', name: 'search_hint', desc: '', args: []);
  }

  /// `Unknown error`
  String get unknown_error {
    return Intl.message(
      'Unknown error',
      name: 'unknown_error',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get try_again {
    return Intl.message('Try again', name: 'try_again', desc: '', args: []);
  }

  /// `Success!`
  String get success {
    return Intl.message('Success!', name: 'success', desc: '', args: []);
  }

  /// `Insufficient balance!`
  String get balance_error {
    return Intl.message(
      'Insufficient balance!',
      name: 'balance_error',
      desc: '',
      args: [],
    );
  }

  /// `You don't have enough coins!`
  String get coins_amount_error {
    return Intl.message(
      'You don\'t have enough coins!',
      name: 'coins_amount_error',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error, try again`
  String get unknown_error_try_again {
    return Intl.message(
      'Unknown error, try again',
      name: 'unknown_error_try_again',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Loading...`
  String get loading {
    return Intl.message('Loading...', name: 'loading', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Are you sure you want to sign out?`
  String get signOutConfirm {
    return Intl.message(
      'Are you sure you want to sign out?',
      name: 'signOutConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message('Sign Up', name: 'signUp', desc: '', args: []);
  }

  /// `Sign In`
  String get signIn {
    return Intl.message('Sign In', name: 'signIn', desc: '', args: []);
  }

  /// `Forgot password? Reset password`
  String get forgotPassword {
    return Intl.message(
      'Forgot password? Reset password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Don’t have an account? Create one`
  String get noAccount {
    return Intl.message(
      'Don’t have an account? Create one',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  /// `Reset password`
  String get resetPassword {
    return Intl.message(
      'Reset password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? Sign in`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account? Sign in',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Email Verification`
  String get emailVerification {
    return Intl.message(
      'Email Verification',
      name: 'emailVerification',
      desc: '',
      args: [],
    );
  }

  /// `Check`
  String get check {
    return Intl.message('Check', name: 'check', desc: '', args: []);
  }

  /// `Email sent to your inbox`
  String get emailSent {
    return Intl.message(
      'Email sent to your inbox',
      name: 'emailSent',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resend {
    return Intl.message('Resend', name: 'resend', desc: '', args: []);
  }

  /// `Market Data`
  String get market_data {
    return Intl.message('Market Data', name: 'market_data', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
