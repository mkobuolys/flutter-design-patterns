## Class diagram

![Strategy Class Diagram](resource:assets/images/strategy/strategy.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of the **Strategy** design pattern.

![Strategy Implementation Class Diagram](resource:assets/images/strategy/strategy_implementation.png)

`IShippingCostsStrategy` defines a common interface for all the specific strategies:

- `label` - a text label of the strategy which is used in UI;
- `calculate()` - method to calculate shipping costs for the order. It uses information from the Order class object passed as a parameter.

`InStorePickupStrategy`, `ParcelTerminalShippingStrategy` and `PriorityShippingStrategy` are concrete implementations of the `IShippingCostsStrategy` interface. Each of the strategies provides a specific algorithm for the shipping costs calculation and defines it in the `calculate()` method.

`StrategyExample` widget stores all different shipping costs calculation strategies in the `shippingCostsStrategyList` variable.

### IShippingCostsStrategy

An interface that defines methods and properties to be implemented by all supported algorithms.

```
abstract interface class IShippingCostsStrategy {
  late String label;
  double calculate(Order order);
}
```

### Specific implementations of the `IShippingCostsStrategy` interface

- `InStorePickupStrategy` - implements the shipping strategy which requires the customer to pick-up the order in the store. Hence, there are no shipping costs and the `calculate()` method returns 0.

```dart
class InStorePickupStrategy implements IShippingCostsStrategy {
  @override
  String label = 'In-store pickup';

  @override
  double calculate(Order order) => 0.0;
}
```

- `ParcelTerminalShippingStrategy` - implements the shipping strategy when order is delivered using the parcel terminal service. When using parcel terminals, each order item is sent separately and the shipping cost depends on the parcel size. The final shipping price is calculated by adding up the separate shipping cost of each order item.

```dart
class ParcelTerminalShippingStrategy implements IShippingCostsStrategy {
  @override
  String label = 'Parcel terminal shipping';

  @override
  double calculate(Order order) => order.items.fold<double>(
        0.0,
        (sum, item) => sum + _getOrderItemShippingPrice(item),
      );

  double _getOrderItemShippingPrice(OrderItem orderItem) =>
      switch (orderItem.packageSize) {
        PackageSize.S => 1.99,
        PackageSize.M => 2.49,
        PackageSize.L => 2.99,
        PackageSize.XL => 3.49,
      };
}
```

- `PriorityShippingStrategy` - implements the shipping strategy which has a fixed shipping cost for a single order. In this case, the `calculate()` method returns a specific price of 9.99.

```dart
class PriorityShippingStrategy implements IShippingCostsStrategy {
  @override
  String label = 'Priority shipping';

  @override
  double calculate(Order order) => 9.99;
}
```

### Order

A simple class to store an order's information. `Order` class contains a list of order items, provides a method to add a new `OrderItem` to the order, also defines a getter method `price` which returns the total price of the order (without shipping).

```dart
class Order {
  final List<OrderItem> items = [];

  double get price =>
      items.fold(0.0, (sum, orderItem) => sum + orderItem.price);

  void addOrderItem(OrderItem orderItem) => items.add(orderItem);
}
```

### OrderItem

A simple class to store information of a single order item. `OrderItem` class contains properties to store order item's title, price and the package (parcel) size. Also, the class exposes a named factory constructor `OrderItem.random()` which allows creating/generating an `OrderItem` with random property values.

```dart
class OrderItem {
  const OrderItem({
    required this.title,
    required this.price,
    required this.packageSize,
  });

  final String title;
  final double price;
  final PackageSize packageSize;

  factory OrderItem.random() {
    const packageSizeList = PackageSize.values;

    return OrderItem(
      title: faker.lorem.word(),
      price: random.integer(100, min: 5) - 0.01,
      packageSize: packageSizeList[random.integer(packageSizeList.length)],
    );
  }
}
```

### PackageSize

A special kind of class - `enumeration` - to define different package size of the order item.

```dart
enum PackageSize {
  S,
  M,
  L,
  XL,
}
```

### Example

- `StrategyExample` - implements the example widget of the Strategy design pattern. It contains a list of different shipping strategies (`shippingCostsStrategyList`) and provides it to the `ShippingOptions` widget where the index of a specific strategy is selected by triggering the `setSelectedStrategyIndex()` method. Then, the selected strategy is injected into the `OrderSummary` widget where the final price of the order is calculated.

```dart
class StrategyExample extends StatefulWidget {
  const StrategyExample();

  @override
  _StrategyExampleState createState() => _StrategyExampleState();
}

class _StrategyExampleState extends State<StrategyExample> {
  final List<IShippingCostsStrategy> _shippingCostsStrategyList = [
    InStorePickupStrategy(),
    ParcelTerminalShippingStrategy(),
    PriorityShippingStrategy(),
  ];
  var _selectedStrategyIndex = 0;
  var _order = Order();

  void _addToOrder() => setState(() => _order.addOrderItem(OrderItem.random()));

  void _clearOrder() => setState(() => _order = Order());

  void _setSelectedStrategyIndex(int? index) {
    if (index == null) return;

    setState(() => _selectedStrategyIndex = index);
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            OrderButtons(
              onAdd: _addToOrder,
              onClear: _clearOrder,
            ),
            const SizedBox(height: LayoutConstants.spaceM),
            Stack(
              children: <Widget>[
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: _order.items.isEmpty ? 1.0 : 0.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Your order is empty',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: _order.items.isEmpty ? 0.0 : 1.0,
                  child: Column(
                    children: <Widget>[
                      OrderItemsTable(
                        orderItems: _order.items,
                      ),
                      const SizedBox(height: LayoutConstants.spaceM),
                      ShippingOptions(
                        selectedIndex: _selectedStrategyIndex,
                        shippingOptions: _shippingCostsStrategyList,
                        onChanged: _setSelectedStrategyIndex,
                      ),
                      OrderSummary(
                        shippingCostsStrategy:
                            _shippingCostsStrategyList[_selectedStrategyIndex],
                        order: _order,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

- `ShippingOptions` - handles the selection of a specific shipping strategy. The widget provides a radio button list item for each strategy in the `shippingOptions` list. After selecting a specific shipping strategy, the `onChanged()` method is triggered and the selected index is passed to the parent widget (`StrategyExample`). This implementation allows us to change the specific shipping costs calculation strategy at run-time.

```dart
class ShippingOptions extends StatelessWidget {
  final List<IShippingCostsStrategy> shippingOptions;
  final int selectedIndex;
  final ValueChanged<int?> onChanged;

  const ShippingOptions({
    required this.shippingOptions,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(LayoutConstants.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Select shipping type:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            for (final (i, option) in shippingOptions.indexed)
              RadioListTile<int>(
                title: Text(option.label),
                value: i,
                groupValue: selectedIndex,
                onChanged: onChanged,
                dense: true,
                activeColor: Colors.black,
              ),
          ],
        ),
      ),
    );
  }
}
```

- `OrderSummary` - uses the injected shipping strategy of type `IShippingCostsStrategy` for the final order's price calculation. The widget only cares about the type of a shipping strategy, but not its specific implementation. Hence, we can provide different shipping costs calculation strategies of type `IShippingCostsStrategy` without making any changes to the UI.

```dart
class OrderSummary extends StatelessWidget {
  final Order order;
  final IShippingCostsStrategy shippingCostsStrategy;

  const OrderSummary({
    required this.order,
    required this.shippingCostsStrategy,
  });

  double get shippingPrice => shippingCostsStrategy.calculate(order);
  double get total => order.price + shippingPrice;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(LayoutConstants.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Order summary',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(),
            OrderSummaryRow(
              fontFamily: 'Roboto',
              label: 'Subtotal',
              value: order.price,
            ),
            const SizedBox(height: LayoutConstants.spaceM),
            OrderSummaryRow(
              fontFamily: 'Roboto',
              label: 'Shipping',
              value: shippingPrice,
            ),
            const Divider(),
            OrderSummaryRow(
              fontFamily: 'RobotoMedium',
              label: 'Order total',
              value: total,
            ),
          ],
        ),
      ),
    );
  }
}
```
