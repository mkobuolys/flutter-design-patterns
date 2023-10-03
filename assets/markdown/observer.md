## Class diagram

![Observer Class Diagram](resource:assets/images/observer/observer.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of the **Observer** design pattern:

![Observer Implementation Class Diagram](resource:assets/images/observer/observer_implementation.png)

`StockTicker` is a base class that is used by all the specific stock ticker classes. The class contains `title`, `stockTimer` and `stock` properties, `subscribers` list, provides several methods:

- `subscribe()` - subscribes to the stock ticker;
- `unsubscribe()` - unsubscribes from the stock ticker;
- `notifySubscribers()` - notifies subscribers about the stock change;
- `setStock()` - sets stock value;
- `stopTicker()` - stops ticker emitting stock events.

`GameStopStockTicker`, `GoogleStockTicker` and `TeslaStockTicker` are concrete stock ticker classes that extend the base `StockTicker` class.

`Stock` class contains `symbol`, `changeDirection`, `price` and `changeAmount` properties to store info about the stock.

`StockTickerSymbol` is an enumerator class defining supported stock ticker symbols - GME, GOOGL and TSLA.

`StockChangeDirection` is an enumerator class defining stock change directions - growing and falling.

`StockSubscriber` is an abstract class that is used as a base class for all the specific stock subscriber classes. The class contains `title`, `id` and `stockStreamController` properties, `stockStream` getter and defines the abstract `update()` method to update subscriber state.

`DefaultStockSubscriber` and `GrowingStockSubscriber` are concrete stock subscriber classes that extend the abstract class `StockSubscriber`.

### StockTicker

A base class implementing methods for all the specific stock ticker classes. Property `title` is used in the UI for stock ticker selection, `stockTimer` periodically emits a new stock value that is stored in the `stock` property by using the `setStock()` method. The class also stores a list of stock subscribers that can subscribe to the stock ticker and unsubscribe from it by using the `subscribe()` and `unsubscribe()` respectively. Stock ticker subscribers are notified about the value change by calling the `notifySubscribers()` method. The stock timer could be stopped by calling the `stopTicker()` method.

```dart
base class StockTicker {
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

  void stopTicker() => stockTimer.cancel();
}
```

### Concrete stock ticker classes

All of the specific stock ticker classes extend the abstract `StockTicker` class.

- `GameStopStockTicker` - a stock ticker of the GameStop stocks that emits a new stock event every 2 seconds.

```dart
final class GameStopStockTicker extends StockTicker {
  GameStopStockTicker() {
    title = StockTickerSymbol.GME.name;
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

- `TeslaStockTicker` - a stock ticker of the Tesla stocks that emits a new stock event every 3 seconds.

```dart
final class TeslaStockTicker extends StockTicker {
  TeslaStockTicker() {
    title = StockTickerSymbol.TSLA.name;
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

- `GoogleStockTicker` - a stock ticker of the Google stocks that emits a new stock event every 5 seconds.

```dart
final class GoogleStockTicker extends StockTicker {
  GoogleStockTicker() {
    title = StockTickerSymbol.GOOGL.name;
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

A simple class to store information about the stock. `Stock` class contains data about the stocker ticker symbol, stock change direction, current price and the change amount.

```dart
class Stock {
  const Stock({
    required this.symbol,
    required this.changeDirection,
    required this.price,
    required this.changeAmount,
  });

  final StockTickerSymbol symbol;
  final StockChangeDirection changeDirection;
  final double price;
  final double changeAmount;
}
```

### StockTickerSymbol

A special kind of class - `enumeration` - to define supported stock ticker symbols.

```dart
enum StockTickerSymbol {
  GME,
  GOOGL,
  TSLA,
}
```

### StockChangeDirection

A special kind of class - `enumeration` - to define stock change directions.

```dart
enum StockChangeDirection {
  falling,
  growing,
}
```

### StockSubscriber

An abstract class containing base properties for all the specific stock ticker classes. Property `title` is used in the UI for stock subscriber selection, `id` uniquely identifies the subscriber. Updated stock values are added to the `stockStreamController` and emitted via the `stockStream`. Abstract method `update()` is defined and must be implemented by all the concrete stock subscriber classes.

```dart
abstract class StockSubscriber {
  late final String title;

  final id = faker.guid.guid();

  @protected
  final StreamController<Stock> stockStreamController =
      StreamController.broadcast();

  Stream<Stock> get stockStream => stockStreamController.stream;

  void update(Stock stock);
}
```

### Concrete stock subscriber classes

- `DefaultStockSubscriber` - a default stock subscriber that emits every stock change on update.

```dart
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

- `GrowingStockSubscriber` - a growing stock subscriber that emits only growing stock changes on update.

```dart
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

`ObserverExample` contains a list of `StockSubscriber` as well as a list of `StockTickerModel` objects (specific `StockTicker` class with a flag of whether the user is subscribed to the stock ticker or not).

A specific subscriber class could be easily changed by using the `StockSubscriberSelection` widget. Also, `StockTickerSelection` allows easily subscribe/unsubscribe from the specific stock ticker at run-time.

```dart
class ObserverExample extends StatefulWidget {
  const ObserverExample();

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
  var _selectedSubscriberIndex = 0;

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

  void _onStockChange(Stock stock) => setState(() => _stockEntries.add(stock));

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

    setState(() => stockTickerModel.toggleSubscribed());
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: LayoutConstants.paddingL,
        ),
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
                  StockRow(stock: stock),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```
