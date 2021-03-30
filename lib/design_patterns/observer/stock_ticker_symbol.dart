// ignore_for_file: constant_identifier_names

enum StockTickerSymbol {
  GME,
  GOOGL,
  TSLA,
}

extension StockTickerSymbolExtension on StockTickerSymbol {
  String toShortString() => toString().split('.').last;
}
