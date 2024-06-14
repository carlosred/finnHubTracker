class Utils {
  static String? fixStockName(String? stockName) {
    var result = stockName;
    if (stockName?.contains(':') == true) {
      result = stockName!.split(':')[0];
    }

    return result;
  }
}
