import 'dart:async';

import '../stock_ticker.dart';
import '../stock_ticker_symbol.dart';

class GameStopStockTicker extends StockTicker {
  GameStopStockTicker() {
    title = StockTickerSymbol.GME.toShortString();
    stockTimer = Timer.periodic(
      const Duration(seconds: 2),
      (_) {
        setStock(StockTickerSymbol.GME, 16000, 22000);
        notifySubscribers();
      },
    );
  }
}
