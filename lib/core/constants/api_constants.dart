abstract class ApiConstants {
  static const _baseUrl = 'https://min-api.cryptocompare.com';

  static String allCoinsUrl(int page) =>
      '$_baseUrl/data/top/mktcapfull?limit=$_limit&tsym=USD&page=$page';

  static String coinUrl(String symbol) =>
      '$_baseUrl/data/pricemultifull?fsyms=$symbol&tsyms=USD';

  static const _limit = 50;
  static const imagesHost = 'https://www.cryptocompare.com';
}
