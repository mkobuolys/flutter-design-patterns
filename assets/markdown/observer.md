## Class diagram

![Observer Class Diagram](resource:assets/images/observer/observer.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of the **Observer** design pattern:

![Observer Implementation Class Diagram](resource:assets/images/observer/observer_implementation.png)

_StockTicker_ is an abstract class that is used as a base class for all the specific stock ticker classes. The class contains _title_, _stockTimer_ and _stock_ properties, _subscribers_ list, provides several methods:

- _subscribe()_ - subscribes to the stock ticker;
- _unsubscribe()_ - unsubscribes from the stock ticker;
- _notifySubscribers()_ - notifies subscribers about the stock change;
- _setStock()_ - sets stock value;
- _stopTicker()_ - stops ticker emitting stock events.

_GameStopStockTicker_, _GoogleStockTicker_ and _TeslaStockTicker_ are concrete stock ticker classes that extend the abstract class _StockTicker_.

_Stock_ class contains _symbol_, _changeDirection_, _price_ and _changeAmount_ properties to store info about the stock.

_StockTickerSymbol_ is an enumerator class defining supported stock ticker symbols - GME, GOOGL and TSLA.

_StockChangeDirection_ is an enumerator class defining stock change directions - growing and falling.

_StockSubscriber_ is an abstract class that is used as a base class for all the specific stock subscriber classes. The class contains _title_, _id_ and _stockStreamController_ properties, _stockStream_ getter and defines the abstract _update()_ method to update subscriber state.

_DefaultStockSubscriber_ and _GrowingStockSubscriber_ are concrete stock subscriber classes that extend the abstract class _StockSubscriber_.

### StockTicker

An abstract class implementing base methods for all the specific stock ticker classes. Property _title_ is used in the UI for stock ticker selection, _stockTimer_ periodically emits a new stock value that is stored in the _stock_ property by using the _setStock()_ method. The class also stores a list of stock subscribers that can subscribe to the stock ticker and unsubscribe from it by using the _subscribe()_ and _unsubscribe()_ respectively. Stock ticker subscribers are notified about the value change by calling the _notifySubscribers()_ method. The stock timer could be stopped by calling the _stopTicker()_ method.

```
abstract class StockTicker {
  late final String title;
  late final Timer stockTimer;

  @protected
  Stock? stock;

  final _subscribers = <StockSubscriber>[];

  void subscribe(StockSubscriber subscriber) => _subscribers.add(subscriber);

  void unsubscribe(StockSubscriber subscriber) =>
      _subscribers.removeWhere((s) => s.id == subscriber.id);

  void notifySubscribers() {
    for (final subscriber in _subscribers) {
      subscriber.update(stock!);
    }
  }

  void setStock(StockTickerSymbol stockTickerSymbol, int min, int max) {
    final lastStock = stock;
    final price = faker.randomGenerator.integer(max, min: min) / 100;
    final changeAmount = lastStock != null ? price - lastStock.price : 0.0;

    stock = Stock(
      changeAmount: changeAmount.abs(),
      changeDirection: changeAmount > 0
          ? StockChangeDirection.growing
          : StockChangeDirection.falling,
      price: price,
      symbol: stockTickerSymbol,
    );
  }

  void stopTicker() {
    stockTimer.cancel();
  }
}
```

### Concrete stock ticker classes

All of the specific stock ticker classes extend the abstract _StockTicker_ class.

- _GameStopStockTicker_ - a stock ticker of the GameStop stocks that emits a new stock event every 2 seconds.

```
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
```

- _TeslaStockTicker_ - a stock ticker of the Tesla stocks that emits a new stock event every 3 seconds.

```
class TeslaStockTicker extends StockTicker {
  TeslaStockTicker() {
    title = StockTickerSymbol.TSLA.toShortString();
    stockTimer = Timer.periodic(
      const Duration(seconds: 3),
      (_) {
        setStock(StockTickerSymbol.TSLA, 60000, 65000);
        notifySubscribers();
      },
    );
  }
}
```

- _GoogleStockTicker_ - a stock ticker of the Google stocks that emits a new stock event every 5 seconds.

```
class GoogleStockTicker extends StockTicker {
  GoogleStockTicker() {
    title = StockTickerSymbol.GOOGL.toShortString();
    stockTimer = Timer.periodic(
      const Duration(seconds: 5),
      (_) {
        setStock(StockTickerSymbol.GOOGL, 200000, 204000);
        notifySubscribers();
      },
    );
  }
}
```

### Stock

A simple class to store information about the stock. _Stock_ class contains data about the stocker ticker symbol, stock change direction, current price and the change amount.

```
class Stock {
  final StockTickerSymbol symbol;
  final StockChangeDirection changeDirection;
  final double price;
  final double changeAmount;

  const Stock({
    required this.symbol,
    required this.changeDirection,
    required this.price,
    required this.changeAmount,
  });
}
```

### StockTickerSymbol

A special kind of class - _enumeration_ - to define supported stock ticker symbols. Also, there is a _StockTickerSymbolExtension_ defined where the _toShortString()_ method returns a short version of the enumeration string value.

```
enum StockTickerSymbol {
  GME,
  GOOGL,
  TSLA,
}

extension StockTickerSymbolExtension on StockTickerSymbol {
  String toShortString() => toString().split('.').last;
}
```

### StockChangeDirection

A special kind of class - _enumeration_ - to define stock change directions.

```
enum StockChangeDirection {
  falling,
  growing,
}
```

### StockSubscriber

An abstract class containing base properties for all the specific stock ticker classes. Property _title_ is used in the UI for stock subscriber selection, _id_ uniquely identifies the subscriber. Updated stock values are added to the _stockStreamController_ and emitted via the _stockStream_. Abstract method _update()_ is defined and must be implemented by all the concrete stock subscriber classes.

```
abstract class StockSubscriber {
  late final String title;

  final id = faker.guid.guid()!;

  @protected
  final StreamController<Stock> stockStreamController =
      StreamController.broadcast();

  Stream<Stock> get stockStream => stockStreamController.stream;

  void update(Stock stock);
}
```

### Concrete stock subscriber classes

- _DefaultStockSubscriber_ - a default stock subscriber that emits every stock change on update.

```
class DefaultStockSubscriber extends StockSubscriber {
  DefaultStockSubscriber() {
    title = 'All stocks';
  }

  @override
  void update(Stock stock) {
    stockStreamController.add(stock);
  }
}
```

- _GrowingStockSubscriber_ - a growing stock subscriber that emits only growing stock changes on update.

```
class GrowingStockSubscriber extends StockSubscriber {
  GrowingStockSubscriber() {
    title = 'Growing stocks';
  }

  @override
  void update(Stock stock) {
    if (stock.changeDirection == StockChangeDirection.growing) {
      stockStreamController.add(stock);
    }
  }
}
```

### Example

_ObserverExample_ contains a list of _StockSubscriber_ as well as a list of _StockTickerModel_ objects (specific _StockTicker_ class with a flag of whether the user is subscribed to the stock ticker or not).

A specific subscriber class could be easily changed by using the _StockSubscriberSelection_ widget. Also, _StockTickerSelection_ allows easily subscribe/unsubscribe from the specific stock ticker at run-time.

```
class ObserverExample extends StatefulWidget {
  @override
  _ObserverExampleState createState() => _ObserverExampleState();
}

class _ObserverExampleState extends State<ObserverExample> {
  final _stockSubscriberList = <StockSubscriber>[
    DefaultStockSubscriber(),
    GrowingStockSubscriber(),
  ];
  final _stockTickers = <StockTickerModel>[
    StockTickerModel(stockTicker: GameStopStockTicker()),
    StockTickerModel(stockTicker: GoogleStockTicker()),
    StockTickerModel(stockTicker: TeslaStockTicker()),
  ];
  final _stockEntries = <Stock>[];

  StreamSubscription<Stock>? _stockStreamSubscription;
  StockSubscriber _subscriber = DefaultStockSubscriber();
  int _selectedSubscriberIndex = 0;

  @override
  void initState() {
    super.initState();

    _stockStreamSubscription = _subscriber.stockStream.listen(_onStockChange);
  }

  @override
  void dispose() {
    for (final ticker in _stockTickers) {
      ticker.stockTicker.stopTicker();
    }

    _stockStreamSubscription?.cancel();

    super.dispose();
  }

  void _onStockChange(Stock stock) {
    setState(() {
      _stockEntries.add(stock);
    });
  }

  void _setSelectedSubscriberIndex(int? index) {
    for (final ticker in _stockTickers) {
      if (ticker.subscribed) {
        ticker.toggleSubscribed();
        ticker.stockTicker.unsubscribe(_subscriber);
      }
    }

    _stockStreamSubscription?.cancel();

    setState(() {
      _stockEntries.clear();
      _selectedSubscriberIndex = index!;
      _subscriber = _stockSubscriberList[_selectedSubscriberIndex];
      _stockStreamSubscription = _subscriber.stockStream.listen(_onStockChange);
    });
  }

  void _toggleStockTickerSelection(int index) {
    final stockTickerModel = _stockTickers[index];
    final stockTicker = stockTickerModel.stockTicker;

    if (stockTickerModel.subscribed) {
      stockTicker.unsubscribe(_subscriber);
    } else {
      stockTicker.subscribe(_subscriber);
    }

    setState(() {
      stockTickerModel.toggleSubscribed();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: paddingL),
        child: Column(
          children: <Widget>[
            StockSubscriberSelection(
              stockSubscriberList: _stockSubscriberList,
              selectedIndex: _selectedSubscriberIndex,
              onChanged: _setSelectedSubscriberIndex,
            ),
            StockTickerSelection(
              stockTickers: _stockTickers,
              onChanged: _toggleStockTickerSelection,
            ),
            Column(
              children: [
                for (final stock in _stockEntries.reversed)
                  StockRow(stock: stock)
              ],
            )
          ],
        ),
      ),
    );
  }
}
```
