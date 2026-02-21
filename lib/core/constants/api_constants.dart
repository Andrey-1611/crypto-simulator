abstract class ApiConstants {
  static const baseUrl = 'https://min-api.cryptocompare.com';

  static String coinsByPage(int page) =>
      '/data/top/mktcapfull?limit=50&tsym=USD&page=$page';

  static String coinsByVolume(int page) =>
      '/data/top/totaltoptiervolfull?limit=30&tsym=USD&page=$page';

  static String coinsByMarketCap(int page) =>
      '/data/top/mktcapfull?limit=30&tsym=USD&page=$page';

  static String coinsByPrice(int page) =>
      '/data/top/price?limit=30&tsym=USD&page=$page';

  static String coinsByPercentChange(int page) =>
      '/data/top/percent?limit=10&tsym=USD&page=$page';

  static String coinsBySimbol(String symbol) =>
      '/data/pricemultifull?fsyms=$symbol&tsyms=USD';

  static String coinPriceBySimbol(String symbol) =>
      '/data/price?fsym=$symbol&tsyms=USD';

  static String coinPricesBySimbol(String symbol) =>
      '/data/pricemulti?fsyms=$symbol&tsyms=USD';

  static const imagesHost = 'https://www.cryptocompare.com';

  static const appUrl = 'https://expense-tracker-d697a.firebaseapp.com';
  static const packageName = 'com.example.crypto_simulator';
}
