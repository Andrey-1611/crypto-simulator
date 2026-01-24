abstract class ApiConstants {
  static const baseUrl = 'https://min-api.cryptocompare.com';

  static String coinsUrlByPage(int page) =>
      '/data/top/mktcapfull?limit=50&tsym=USD&page=$page';

  static String coinsUrlBySimbol(String symbol) =>
      '/data/pricemultifull?fsyms=$symbol&tsyms=USD';

  static String coinPriceUrlBySimbol(String symbol) =>
      '/data/price?fsym=$symbol&tsyms=USD';

  static String coinPricesUrlBySimbol(String symbol) =>
      '/data/pricemulti?fsyms=$symbol&tsyms=USD';

  static const imagesHost = 'https://www.cryptocompare.com';
}
