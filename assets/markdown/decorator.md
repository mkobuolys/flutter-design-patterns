## Class diagram

![Decorator Class Diagram](resource:assets/images/decorator/decorator.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of the **Decorator** design pattern.

![Decorator Implementation Class Diagram](resource:assets/images/decorator/decorator_implementation.png)

`Pizza` defines a common interface for wrappers (decorators) and wrapped objects:

- `getDescription()` - returns the description of the pizza;
- `getPrice()` - returns the price of the pizza.

`PizzaBase` represents the component object which implements the `Pizza` interface.

`PizzaDecorator` references the `Pizza` object and forwards requests to it via the `getDescription()` and `getPrice()` methods.

`Basil`, `Mozzarella`, `OliveOil`, `Oregano`, `Pecorino`, `Pepperoni` and `Sauce` are concrete decorators extending the `PizzaDecorator` class and overriding its default behaviour by adding some extra functionality/calculations of their own.

`PizzaToppingData` class stores information about the pizza topping's selection chip used in the UI - its label and whether it is selected or not.

`PizzaMenu` class provides a `getPizzaToppingsDataMap()` method to retrieve the pizza topping's selection chip data. Also, `getPizza()` method is defined to return the specific `Pizza` object based on the selected index in the UI or the selected pizza toppings.

`DecoratorExample` initialises and contains the `PizzaMenu` class object to retrieve the selected `Pizza` object based on the user's selection in the UI.

### Pizza

An interface of the `Pizza` component that defines a common contract for concrete component and decorator objects.

```dart
abstract interface class Pizza {
  String getDescription();
  double getPrice();
}
```

### PizzaBase

A concrete component that implements the `Pizza` interface methods. An object of this class (its behaviour) gets decorated by the specific decorator classes.

```dart
class PizzaBase implements Pizza {
  const PizzaBase(this.description);

  final String description;

  @override
  String getDescription() => description;

  @override
  double getPrice() => 3.0;
}
```

### PizzaDecorator

An abstract decorator class that maintains a reference to a component class and forwards requests to it.

```dart
abstract class PizzaDecorator implements Pizza {
  const PizzaDecorator(this.pizza);

  final Pizza pizza;

  @override
  String getDescription() => pizza.getDescription();

  @override
  double getPrice() => pizza.getPrice();
}
```

### Concrete pizza decorators

`Basil`, `Mozzarella`, `OliveOil`, `Oregano`, `Pecorino`, `Pepperoni` and `Sauce` are concrete decorator classes of the `Pizza` component. Each of these classes wraps the pizza object and adds additional value for the final price in the `getPrice()` method, also extends the final pizza's description in the `getDescription()` method.

```dart
class Basil extends PizzaDecorator {
  const Basil(super.pizza);

  @override
  String getDescription() => '${pizza.getDescription()}\n- Basil';

  @override
  double getPrice() => pizza.getPrice() + 0.2;
}
```

```dart
class Mozzarella extends PizzaDecorator {
  const Mozzarella(super.pizza);

  @override
  String getDescription() => '${pizza.getDescription()}\n- Mozzarella';

  @override
  double getPrice() => pizza.getPrice() + 0.5;
}
```

```dart
class OliveOil extends PizzaDecorator {
  const OliveOil(super.pizza);

  @override
  String getDescription() => '${pizza.getDescription()}\n- Olive Oil';

  @override
  double getPrice() => pizza.getPrice() + 0.1;
}
```

```dart
class Oregano extends PizzaDecorator {
  const Oregano(super.pizza);

  @override
  String getDescription() => '${pizza.getDescription()}\n- Oregano';

  @override
  double getPrice() => pizza.getPrice() + 0.2;
}
```

```dart
class Pecorino extends PizzaDecorator {
  const Pecorino(super.pizza);

  @override
  String getDescription() => '${pizza.getDescription()}\n- Pecorino';

  @override
  double getPrice() => pizza.getPrice() + 0.7;
}
```

```dart
class Pepperoni extends PizzaDecorator {
  const Pepperoni(super.pizza);

  @override
  String getDescription() => '${pizza.getDescription()}\n- Pepperoni';

  @override
  double getPrice() => pizza.getPrice() + 1.5;
}
```

```dart
class Sauce extends PizzaDecorator {
  const Sauce(super.pizza);

  @override
  String getDescription() => '${pizza.getDescription()}\n- Sauce';

  @override
  double getPrice() => pizza.getPrice() + 0.3;
}
```

### PizzaToppingData

A simple class that contains data used by the pizza topping's selection chip in the UI. The data consists of the `label` property and the current selection state (whether the chip is currently selected or not) which could be changed by using the `setSelected()` method.

```dart
class PizzaToppingData {
  PizzaToppingData(this.label);

  final String label;
  bool selected = false;

  void setSelected({required bool isSelected}) => selected = isSelected;
}
```

### PizzaMenu

A simple class that provides a map of `PizzaToppingData` objects via the `getPizzaToppingsDataMap()` method for the pizza toppings selection in UI. Also, the class defines a `getPizza()` method which returns a `Pizza` object that is built by using the pre-defined concrete decorator classes based on the pizza recipe - Margherita, Pepperoni or custom (based on the selected pizza toppings).

This class (to be more specific, `getMargherita()`, `getPepperoni()` and `getCustom()` methods) represents the main idea of the decorator design pattern - a base component class is instantiated and then wrapped by the concrete decorator classes, hence extending the base class and its behaviour. As a result, it is possible to use wrapper classes and add or remove responsibilities from an object at runtime, for instance, as it is used in the `getCustom()` method where the appropriate decorator classes are used based on the selected pizza toppings data in the UI.

```dart
class PizzaMenu {
  final Map<int, PizzaToppingData> _pizzaToppingsDataMap = {
    1: PizzaToppingData('Basil'),
    2: PizzaToppingData('Mozzarella'),
    3: PizzaToppingData('Olive Oil'),
    4: PizzaToppingData('Oregano'),
    5: PizzaToppingData('Pecorino'),
    6: PizzaToppingData('Pepperoni'),
    7: PizzaToppingData('Sauce'),
  };

  Map<int, PizzaToppingData> getPizzaToppingsDataMap() => _pizzaToppingsDataMap;

  Pizza getPizza(int index, Map<int, PizzaToppingData> pizzaToppingsDataMap) =>
      switch (index) {
        0 => _getMargherita(),
        1 => _getPepperoni(),
        2 => _getCustom(pizzaToppingsDataMap),
        _ => throw Exception("Index of '$index' does not exist."),
      };

  Pizza _getMargherita() {
    Pizza pizza = const PizzaBase('Pizza Margherita');
    pizza = Sauce(pizza);
    pizza = Mozzarella(pizza);
    pizza = Basil(pizza);
    pizza = Oregano(pizza);
    pizza = Pecorino(pizza);
    pizza = OliveOil(pizza);

    return pizza;
  }

  Pizza _getPepperoni() {
    Pizza pizza = const PizzaBase('Pizza Pepperoni');
    pizza = Sauce(pizza);
    pizza = Mozzarella(pizza);
    pizza = Pepperoni(pizza);
    pizza = Oregano(pizza);

    return pizza;
  }

  Pizza _getCustom(Map<int, PizzaToppingData> pizzaToppingsDataMap) {
    Pizza pizza = const PizzaBase('Custom Pizza');

    if (pizzaToppingsDataMap[1]!.selected) pizza = Basil(pizza);
    if (pizzaToppingsDataMap[2]!.selected) pizza = Mozzarella(pizza);
    if (pizzaToppingsDataMap[3]!.selected) pizza = OliveOil(pizza);
    if (pizzaToppingsDataMap[4]!.selected) pizza = Oregano(pizza);
    if (pizzaToppingsDataMap[5]!.selected) pizza = Pecorino(pizza);
    if (pizzaToppingsDataMap[6]!.selected) pizza = Pepperoni(pizza);
    if (pizzaToppingsDataMap[7]!.selected) pizza = Sauce(pizza);

    return pizza;
  }
}
```

### Example

`DecoratorExample` contains the `PizzaMenu` object which is used to get the specific `Pizza` object based on the user's selection. Also, all the logic related to the decorator's design pattern and its implementation is extracted to the `PizzaMenu` class, the `DecoratorExample` widget only uses it to retrieve the necessary data to be represented in the UI.

```dart
class DecoratorExample extends StatefulWidget {
  const DecoratorExample();

  @override
  _DecoratorExampleState createState() => _DecoratorExampleState();
}

class _DecoratorExampleState extends State<DecoratorExample> {
  final pizzaMenu = PizzaMenu();

  late final Map<int, PizzaToppingData> _pizzaToppingsDataMap;
  late Pizza _pizza;
  var _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pizzaToppingsDataMap = pizzaMenu.getPizzaToppingsDataMap();
    _pizza = pizzaMenu.getPizza(0, _pizzaToppingsDataMap);
  }

  void _onSelectedIndexChanged(int? index) {
    _setSelectedIndex(index!);
    _setSelectedPizza(index);
  }

  void _setSelectedIndex(int index) => setState(() => _selectedIndex = index);

  void _onCustomPizzaChipSelected(int index, bool? selected) {
    _setChipSelected(index, selected!);
    _setSelectedPizza(_selectedIndex);
  }

  void _setChipSelected(int index, bool selected) => setState(() {
        _pizzaToppingsDataMap[index]!.setSelected(isSelected: selected);
      });

  void _setSelectedPizza(int index) => setState(() {
        _pizza = pizzaMenu.getPizza(index, _pizzaToppingsDataMap);
      });

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
            Row(
              children: <Widget>[
                Text(
                  'Select your pizza:',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            PizzaSelection(
              selectedIndex: _selectedIndex,
              onChanged: _onSelectedIndexChanged,
            ),
            if (_selectedIndex == 2)
              CustomPizzaSelection(
                pizzaToppingsDataMap: _pizzaToppingsDataMap,
                onSelected: _onCustomPizzaChipSelected,
              ),
            PizzaInformation(
              pizza: _pizza,
            ),
          ],
        ),
      ),
    );
  }
}
```
