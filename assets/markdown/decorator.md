## Class diagram

![Decorator Class Diagram](resource:assets/images/decorator/decorator.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of the **Decorator** design pattern.

![Decorator Implementation Class Diagram](resource:assets/images/decorator/decorator_implementation.png)

_Pizza_ defines a common interface for wrappers (decorators) and wrapped objects:

- _getDescription()_ - returns the description of the pizza;
- _getPrice()_ - returns the price of the pizza.

_PizzaBase_ represents the component object which extends the _Pizza_ class and implements its abstract methods.

_PizzaDecorator_ references the _Pizza_ object and forwards requests to it via the _getDescription()_ and _getPrice()_ methods.

_Basil_, _Mozzarella_, _OliveOil_, _Oregano_, _Pecorino_, _Pepperoni_ and _Sauce_ are concrete decorators extending the _PizzaDecorator_ class and overriding its default behaviour by adding some extra functionality/calculations of their own.

_PizzaToppingData_ class stores information about the pizza topping's selection chip used in the UI - its label and whether it is selected or not.

_PizzaMenu_ class provides a _getPizzaToppingsDataMap()_ method to retrieve the pizza topping's selection chip data. Also, _getPizza()_ method is defined to return the specific _Pizza_ object based on the selected index in the UI or the selected pizza toppings.

_DecoratorExample_ initialises and contains the _PizzaMenu_ class object to retrieve the selected _Pizza_ object based on the user's selection in the UI.

### Pizza

An abstract class of the _Pizza_ component which defines a common interface for concrete component and decorator objects.

```
abstract class Pizza {
  String description;

  String getDescription();
  double getPrice();
}
```

### PizzaBase

A concrete component which extends the _Pizza_ class and implements its methods. An object of this class (its behaviour) gets decorated by the specific decorator classes.

```
class PizzaBase extends Pizza {
  PizzaBase(String description) {
    this.description = description;
  }

  @override
  String getDescription() {
    return description;
  }

  @override
  double getPrice() {
    return 3.0;
  }
}
```

### PizzaDecorator

An abstract decorator class which maintains a reference to a component class and forwards requests to it.

```
abstract class PizzaDecorator extends Pizza {
  final Pizza pizza;

  PizzaDecorator(this.pizza);

  @override
  String getDescription() {
    return pizza.getDescription();
  }

  @override
  double getPrice() {
    return pizza.getPrice();
  }
}
```

### Concrete pizza decorators

_Basil_, _Mozzarella_, _OliveOil_, _Oregano_, _Pecorino_, _Pepperoni_ and _Sauce_ are concrete decorator classes of the _Pizza_ component. Each of these classes wraps the pizza object and adds additional value for the final price in the _getPrice()_ method, also extends the final pizza's description in the _getDescription()_ method.

```
class Basil extends PizzaDecorator {
  Basil(Pizza pizza) : super(pizza) {
    description = 'Basil';
  }

  @override
  String getDescription() {
    return '${pizza.getDescription()}\n- $description';
  }

  @override
  double getPrice() {
    return pizza.getPrice() + 0.2;
  }
}
```

```
class Mozzarella extends PizzaDecorator {
  Mozzarella(Pizza pizza) : super(pizza) {
    description = 'Mozzarella';
  }

  @override
  String getDescription() {
    return '${pizza.getDescription()}\n- $description';
  }

  @override
  double getPrice() {
    return pizza.getPrice() + 0.5;
  }
}
```

```
class OliveOil extends PizzaDecorator {
  OliveOil(Pizza pizza) : super(pizza) {
    description = 'Olive Oil';
  }

  @override
  String getDescription() {
    return '${pizza.getDescription()}\n- $description';
  }

  @override
  double getPrice() {
    return pizza.getPrice() + 0.1;
  }
}
```

```
class Oregano extends PizzaDecorator {
  Oregano(Pizza pizza) : super(pizza) {
    description = 'Oregano';
  }

  @override
  String getDescription() {
   return '${pizza.getDescription()}\n- $description';
  }

  @override
  double getPrice() {
    return pizza.getPrice() + 0.2;
  }
}
```

```
class Pecorino extends PizzaDecorator {
  Pecorino(Pizza pizza) : super(pizza) {
    description = 'Pecorino';
  }

  @override
  String getDescription() {
    return '${pizza.getDescription()}\n- $description';
  }

  @override
  double getPrice() {
    return pizza.getPrice() + 0.7;
  }
}
```

```
class Pepperoni extends PizzaDecorator {
  Pepperoni(Pizza pizza) : super(pizza) {
    description = 'Pepperoni';
  }

  @override
  String getDescription() {
    return '${pizza.getDescription()}\n- $description';
  }

  @override
  double getPrice() {
    return pizza.getPrice() + 1.5;
  }
}
```

```
class Sauce extends PizzaDecorator {
  Sauce(Pizza pizza) : super(pizza) {
    description = 'Sauce';
  }

  @override
  String getDescription() {
    return '${pizza.getDescription()}\n- $description';
  }

  @override
  double getPrice() {
    return pizza.getPrice() + 0.3;
  }
}
```

### PizzaToppingData

A simple class which contains data used by the pizza topping's selection chip in the UI. The data consists of the _label_ property and the current selection state (whether the chip is currently selected or not) which could be changed by using the _setSelected()_ method.

```
class PizzaToppingData {
  final String label;
  bool selected = false;

  PizzaToppingData(this.label);

  void setSelected(bool value) {
    selected = value;
  }
}
```

### PizzaMenu

A simple class which provides a map of _PizzaToppingData_ objects via the _getPizzaToppingsDataMap()_ method for the pizza toppings selection in UI. Also, the class defines a _getPizza()_ method which returns a _Pizza_ object that is built by using the pre-defined concrete decorator classes based on the pizza recipe - Margherita, Pepperoni or custom (based on the selected pizza toppings).

This class (to be more specific, _getMargherita()_, _getPepperoni()_ and _getCustom()_ methods) represents the main idea of the decorator design pattern - a base component class is instantiated and then wrapped by the concrete decorator classes, hence extending the base class and its behaviour. As a result, it is possible to use wrapper classes and add or remove responsibilities from an object at runtime, for instance, as it is used in the _getCustom()_ method where the appropriate decorator classes are used based on the selected pizza toppings data in the UI.

```
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

  Pizza getPizza(int index, Map<int, PizzaToppingData> pizzaToppingsDataMap) {
    switch (index) {
      case 0:
        return _getMargherita();
      case 1:
        return _getPepperoni();
      case 2:
        return _getCustom(pizzaToppingsDataMap);
    }

    throw Exception("Index of '$index' does not exist.");
  }

  Pizza _getMargherita() {
    Pizza pizza = PizzaBase('Pizza Margherita');
    pizza = Sauce(pizza);
    pizza = Mozzarella(pizza);
    pizza = Basil(pizza);
    pizza = Oregano(pizza);
    pizza = Pecorino(pizza);
    pizza = OliveOil(pizza);

    return pizza;
  }

  Pizza _getPepperoni() {
    Pizza pizza = PizzaBase('Pizza Pepperoni');
    pizza = Sauce(pizza);
    pizza = Mozzarella(pizza);
    pizza = Pepperoni(pizza);
    pizza = Oregano(pizza);

    return pizza;
  }

  Pizza _getCustom(Map<int, PizzaToppingData> pizzaToppingsDataMap) {
    Pizza pizza = PizzaBase('Custom Pizza');

    if (pizzaToppingsDataMap[1].selected) {
      pizza = Basil(pizza);
    }

    if (pizzaToppingsDataMap[2].selected) {
      pizza = Mozzarella(pizza);
    }

    if (pizzaToppingsDataMap[3].selected) {
      pizza = OliveOil(pizza);
    }

    if (pizzaToppingsDataMap[4].selected) {
      pizza = Oregano(pizza);
    }

    if (pizzaToppingsDataMap[5].selected) {
      pizza = Pecorino(pizza);
    }

    if (pizzaToppingsDataMap[6].selected) {
      pizza = Pepperoni(pizza);
    }

    if (pizzaToppingsDataMap[7].selected) {
      pizza = Sauce(pizza);
    }

    return pizza;
  }
}
```

### Example

_DecoratorExample_ contains the _PizzaMenu_ object which is used to get the specific _Pizza_ object based on the user's selection. Also, all the logic related to the decorator's design pattern and its implementation is extracted to the _PizzaMenu_ class, the _DecoratorExample_ widget only uses it to retrieve the necessary data to be represented in the UI.

```
class DecoratorExample extends StatefulWidget {
  @override
  _DecoratorExampleState createState() => _DecoratorExampleState();
}

class _DecoratorExampleState extends State<DecoratorExample> {
  final PizzaMenu pizzaMenu = PizzaMenu();

  Map<int, PizzaToppingData> _pizzaToppingsDataMap;
  Pizza _pizza;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pizzaToppingsDataMap = pizzaMenu.getPizzaToppingsDataMap();
    _pizza = pizzaMenu.getPizza(0, _pizzaToppingsDataMap);
  }

  void _onSelectedIndexChanged(int index) {
    _setSelectedIndex(index);
    _setSelectedPizza(index);
  }

  void _setSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onCustomPizzaChipSelected(int index, bool selected) {
    _setChipSelected(index, selected);
    _setSelectedPizza(_selectedIndex);
  }

  void _setChipSelected(int index, bool selected) {
    setState(() {
      _pizzaToppingsDataMap[index].setSelected(selected);
    });
  }

  void _setSelectedPizza(int index) {
    setState(() {
      _pizza = pizzaMenu.getPizza(index, _pizzaToppingsDataMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: paddingL),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Select your pizza:',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
            PizzaSelection(
              selectedIndex: _selectedIndex,
              onChanged: _onSelectedIndexChanged,
            ),
            AnimatedContainer(
              height: _selectedIndex == 2 ? 100.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: CustomPizzaSelection(
                pizzaToppingsDataMap: _pizzaToppingsDataMap,
                onSelected: _onCustomPizzaChipSelected,
              ),
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
