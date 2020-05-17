## Class diagram

![Strategy Class Diagram](resource:assets/images/strategy/strategy.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of the **Strategy** design pattern.

![Strategy Implementation Class Diagram](resource:assets/images/strategy/strategy_implementation.png)

_IShippingCostsStrategy_ defines a common interface for all the specific strategies:

- _label_ - a text label of the strategy which is used in UI;
- _calculate()_ - method to calculate shipping costs for the order. It uses information from the Order class object passed as a parameter.

_InStorePickupStrategy_, _ParcelTerminalShippingStrategy_ and _PriorityShippingStrategy_ are concrete implementations of the _IShippingCostsStrategy_ interface. Each of the strategies provides a specific algorithm for the shipping costs calculation and defines it in the _calculate()_ method.

_StrategyExample_ widget stores all different shipping costs calculation strategies in the _shippingCostsStrategyList_ variable.

### IShippingCostsStrategy

An interface which defines methods and properties to be implemented by all supported algorithms. Dart language does not support the interface as a class type, so we define an interface by creating an abstract class and providing a method header (name, return type, parameters) without the default implementation.

```
abstract class IShippingCostsStrategy {
  String label;
  double calculate(Order order);
}
```

### Specific implementations of the _IShippingCostsStrategy_ interface

- _InStorePickupStrategy_ - implements the shipping strategy which requires the customer to pick-up the order in the store. Hence, there are no shipping costs and the _calculate()_ method returns 0.

```
class InStorePickupStrategy implements IShippingCostsStrategy {
  @override
  String label = 'In-store pickup';

  @override
  double calculate(Order order) {
    return 0.0;
  }
}
```

- _ParcelTerminalShippingStrategy_ - implements the shipping strategy when order is delivered using the parcel terminal service. When using parcel terminals, each order item is sent separately and the shipping cost depends on the parcel size. The final shipping price is calculated by adding up the separate shipping cost of each order item.

```
class ParcelTerminalShippingStrategy implements IShippingCostsStrategy {
  @override
  String label = 'Parcel terminal shipping';

  @override
  double calculate(Order order) {
    return order.items.fold<double>(
      0.0,
      (sum, item) => sum + _getOrderItemShippingPrice(item),
    );
  }

  double _getOrderItemShippingPrice(OrderItem orderItem) {
    switch (orderItem.packageSize) {
      case PackageSize.S:
        return 1.99;
      case PackageSize.M:
        return 2.49;
      case PackageSize.L:
        return 2.99;
      case PackageSize.XL:
        return 3.49;
      default:
        throw new Exception(
            "Unknown shipping price for the package of size '${orderItem.packageSize}'.");
    }
  }
}
```

- _PriorityShippingStrategy_ - implements the shipping strategy which has a fixed shipping cost for a single order. In this case, the _calculate()_ method returns a specific price of 9.99.

```
class PriorityShippingStrategy implements IShippingCostsStrategy {
  @override
  String label = 'Priority shipping';

  @override
  double calculate(Order order) {
    return 9.99;
  }
}
```

### Order

A simple class to store an order's information. _Order_ class contains a list of order items, provides a method to add a new _OrderItem_ to the order, also defines a getter method _price_ which returns the total price of the order (without shipping).

```
class Order {
  final List<OrderItem> items = List<OrderItem>();

  double get price =>
      items.fold(0.0, (sum, orderItem) => sum + orderItem.price);

  void addOrderItem(OrderItem orderItem) {
    items.add(orderItem);
  }
}
```

### OrderItem

A simple class to store information of a single order item. _OrderItem_ class contains properties to store order item's title, price and the package (parcel) size. Also, the class exposes a named constructor _OrderItem.random()_ which allows creating/generating an _OrderItem_ with random property values.

```
class OrderItem {
  String title;
  double price;
  PackageSize packageSize;

  OrderItem.random() {
    var packageSizeList = PackageSize.values;

    title = faker.lorem.word();
    price = random.integer(100, min: 5) - 0.01;
    packageSize = packageSizeList[random.integer(packageSizeList.length)];
  }
}
```

### PackageSize

A special kind of class - _enumeration_ - to define different package size of the order item.

```
enum PackageSize {
  S,
  M,
  L,
  XL,
}
```

### Example

- _StrategyExample_ - implements the example widget of the Strategy design pattern. It contains a list of different shipping strategies (_shippingCostsStrategyList_) and provides it to the _ShippingOptions_ widget where the index of a specific strategy is selected by triggering the _setSelectedStrategyIndex()_ method. Then, the selected strategy is injected into the _OrderSummary_ widget where the final price of the order is calculated.

```
class StrategyExample extends StatefulWidget {
  @override
  _StrategyExampleState createState() => _StrategyExampleState();
}

class _StrategyExampleState extends State<StrategyExample> {
  final List<IShippingCostsStrategy> _shippingCostsStrategyList = [
    InStorePickupStrategy(),
    ParcelTerminalShippingStrategy(),
    PriorityShippingStrategy(),
  ];
  int _selectedStrategyIndex = 0;
  Order _order = Order();

  void _addToOrder() {
    setState(() {
      _order.addOrderItem(OrderItem.random());
    });
  }

  void _clearOrder() {
    setState(() {
      _order = Order();
    });
  }

  void _setSelectedStrategyIndex(int index) {
    setState(() {
      _selectedStrategyIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            OrderButtons(
              onAdd: _addToOrder,
              onClear: _clearOrder,
            ),
            const SizedBox(height: spaceM),
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
                        style: Theme.of(context).textTheme.headline6,
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
                      const SizedBox(height: spaceM),
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

- _ShippingOptions_ - handles the selection of a specific shipping strategy. The widget provides a radio button list item for each strategy in the _shippingOptions_ list. After selecting a specific shipping strategy, the _onChanged()_ method is triggered and the selected index is passed to the parent widget (_StrategyExample_). This implementation allows us to change the specific shipping costs calculation strategy at run-time.

```
class ShippingOptions extends StatelessWidget {
  final List<IShippingCostsStrategy> shippingOptions;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const ShippingOptions({
    @required this.shippingOptions,
    @required this.selectedIndex,
    @required this.onChanged,
  })  : assert(shippingOptions != null),
        assert(selectedIndex != null),
        assert(onChanged != null);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Select shipping type:',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            for (var i = 0; i < shippingOptions.length; i++)
              RadioListTile<int>(
                title: Text(shippingOptions[i].label),
                value: i,
                groupValue: selectedIndex,
                onChanged: onChanged,
                dense: true,
                activeColor: Colors.black,
                controlAffinity: ListTileControlAffinity.platform,
              ),
          ],
        ),
      ),
    );
  }
}
```

- _OrderSummary_ - uses the injected shipping strategy of type _IShippingCostsStrategy_ for the final order's price calculation. The widget only cares about the type of a shipping strategy, but not its specific implementation. Hence, we can provide different shipping costs calculation strategies of type _IShippingCostsStrategy_ without making any changes to the UI.

```
class OrderSummary extends StatelessWidget {
  final Order order;
  final IShippingCostsStrategy shippingCostsStrategy;

  const OrderSummary({
    @required this.order,
    @required this.shippingCostsStrategy,
  })  : assert(order != null),
        assert(shippingCostsStrategy != null);

  double get shippingPrice => shippingCostsStrategy.calculate(order);
  double get total => order.price + shippingPrice;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Order summary',
              style: Theme.of(context).textTheme.headline6,
            ),
            const Divider(),
            OrderSummaryRow(
              fontFamily: 'Roboto',
              label: 'Subtotal',
              value: order.price,
            ),
            const SizedBox(height: spaceM),
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
