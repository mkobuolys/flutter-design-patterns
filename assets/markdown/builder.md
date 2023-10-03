## Class diagram

![Builder Class Diagram](resource:assets/images/builder/builder.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of **Builder** design pattern.

![Builder Implementation Class Diagram](resource:assets/images/builder/builder_implementation.png)

The `Ingredient` is an abstract class that is used as a base class for all the ingredient classes. The class contains `allergens` and `name` properties as well as `getAllergens()` and `getName()` methods to return values of these properties.

There are a lot of concrete ingredient classes: `BigMacBun`, `RegularBun`, `BeefPatty`, `McChickenPatty`, `BigMacSauce`, `Ketchup`, `Mayonnaise`, `Mustard`, `Onions`, `PickleSlices`, `ShreddedLettuce`, `Cheese` and `GrillSeasoning`. All of these classes represent a specific ingredient of a burger and contains a default constructor to set the `allergens` and `name` property values of the base class.

`Burger` is a simple class representing the product of a builder. It contains `ingredients` list and `price` property to store the corresponding values. Also, the class contains several methods:

- `addIngredient()` - adds an ingredient to the burger;
- `getFormattedIngredients()` - returns a formatted ingredients' list of a burger (separated by commas);
- `getFormattedAllergens()` - returns a formatted allergens' list of a burger (separated by commas);
- `getFormattedPrice()` - returns a formatted price of a burger;
- `setPrice()` - sets the price for the burger.

`BurgerBuilderBase` is an abstract class that is used as a base class for all the burger builder classes. It contains `burger` and `price` properties to store the final product - burger - and its price correspondingly. Additionally, the class stores some methods with default implementation:

- `createBurger()` - initialises a `Burger` class object;
- `getBurger()` - returns the built burger result;
- `setBurgerPrice()` - sets the price for the burger object.

`BurgerBuilderBase` also contain several abstract methods which must be implemented in the specific implementation classes of the burger builder: `addBuns()`, `addCheese()`, `addPatties()`, `addSauces()`, `addSeasoning()` and `addVegetables()`.

`BigMacBuilder`, `CheeseburgerBuilder`, `HamburgerBuilder` and `McChickenBuilder` are concrete builder classes that extend the abstract class `BurgerBuilderBase` and implement its abstract methods.

`BurgerMaker` is director class that manages the burger's build process. It contains a specific builder implementation as a `burgerBuilder` property, `prepareBurger()` method to build the burger and a `getBurger()` method to return it. Also, the builder's implementation could be changed using the `changeBurgerBuilder()` method.

`BuilderExample` initialises and contains the `BurgerMaker` class. Also, it references all the specific burger builders which could be changed at run-time using the UI dropdown selection.

### Ingredient

An abstract class that stores the `allergens`, `name` fields and is extended by all of the ingredient classes.

```dart
abstract class Ingredient {
  @protected
  late List<String> allergens;
  @protected
  late String name;

  List<String> getAllergens() => allergens;

  String getName() => name;
}
```

### Concrete ingredients

All of these classes represent a specific ingredient by extending the `Ingredient` class and specifying an allergens' list as well as the name value.

```dart
class BigMacBun extends Ingredient {
  BigMacBun() {
    name = 'Big Mac Bun';
    allergens = ['Wheat'];
  }
}
```

```dart
class RegularBun extends Ingredient {
  RegularBun() {
    name = 'Regular Bun';
    allergens = ['Wheat'];
  }
}
```

```dart
class BeefPatty extends Ingredient {
  BeefPatty() {
    name = 'Beef Patty';
    allergens = [];
  }
}
```

```dart
class McChickenPatty extends Ingredient {
  McChickenPatty() {
    name = 'McChicken Patty';
    allergens = [
      'Wheat',
      'Cooked in the same fryer that we use for Buttermilk Crispy Chicken which contains a milk allergen',
    ];
  }
}
```

```dart
class BigMacSauce extends Ingredient {
  BigMacSauce() {
    name = 'Big Mac Sauce';
    allergens = ['Egg', 'Soy', 'Wheat'];
  }
}
```

```dart
class Ketchup extends Ingredient {
  Ketchup() {
    name = 'Ketchup';
    allergens = [];
  }
}
```

```dart
class Mayonnaise extends Ingredient {
  Mayonnaise() {
    name = 'Mayonnaise';
    allergens = ['Egg'];
  }
}
```

```dart
class Mustard extends Ingredient {
  Mustard() {
    name = 'Mustard';
    allergens = [];
  }
}
```

```dart
class Onions extends Ingredient {
  Onions() {
    name = 'Onions';
    allergens = [];
  }
}
```

```dart
class PickleSlices extends Ingredient {
  PickleSlices() {
    name = 'Pickle Slices';
    allergens = [];
  }
}
```

```dart
class ShreddedLettuce extends Ingredient {
  ShreddedLettuce() {
    name = 'Shredded Lettuce';
    allergens = [];
  }
}
```

```dart
class Cheese extends Ingredient {
  Cheese() {
    name = 'Cheese';
    allergens = ['Milk', 'Soy'];
  }
}
```

```dart
class GrillSeasoning extends Ingredient {
  GrillSeasoning() {
    name = 'Grill Seasoning';
    allergens = [];
  }
}
```

### Burger

A simple class to store information about the burger: its price and a list of ingredients it contains. Also, class methods, such as `getFormattedIngredients()`, `getFormattedAllergens()` and `getFormattedPrice()`, returns these values in human-readable format.

```dart
class Burger {
  final List<Ingredient> _ingredients = [];
  late double _price;

  void addIngredient(Ingredient ingredient) => _ingredients.add(ingredient);

  String getFormattedIngredients() =>
      _ingredients.map((x) => x.getName()).join(', ');

  String getFormattedAllergens() => <String>{
        for (final ingredient in _ingredients) ...ingredient.getAllergens(),
      }.join(', ');

  String getFormattedPrice() => '\$${_price.toStringAsFixed(2)}';

  void setPrice(double price) => _price = price;
}
```

### BurgerBuilderBase

An abstract class that stores `burger` and `price` properties, defines some default methods to create/return the burger object and set its price. Also, the class defines several abstract methods which must be implemented by the derived burger builder classes.

```dart
abstract class BurgerBuilderBase {
  @protected
  late Burger burger;
  @protected
  late double price;

  void createBurger() => burger = Burger();

  Burger getBurger() => burger;

  void setBurgerPrice() => burger.setPrice(price);

  void addBuns();
  void addCheese();
  void addPatties();
  void addSauces();
  void addSeasoning();
  void addVegetables();
}
```

### Concrete builders

- `BigMacBuilder` - builds a Big Mac using the following ingredients: `BigMacBun`, `Cheese`, `BeefPatty`, `BigMacSauce`, `GrillSeasoning`, `Onions`, `PickleSlices` and `ShreddedLettuce`.

```dart
class BigMacBuilder extends BurgerBuilderBase {
  BigMacBuilder() {
    price = 3.99;
  }

  @override
  void addBuns() {
    burger.addIngredient(BigMacBun());
  }

  @override
  void addCheese() {
    burger.addIngredient(Cheese());
  }

  @override
  void addPatties() {
    burger.addIngredient(BeefPatty());
  }

  @override
  void addSauces() {
    burger.addIngredient(BigMacSauce());
  }

  @override
  void addSeasoning() {
    burger.addIngredient(GrillSeasoning());
  }

  @override
  void addVegetables() {
    burger.addIngredient(Onions());
    burger.addIngredient(PickleSlices());
    burger.addIngredient(ShreddedLettuce());
  }
}
```

- `CheeseburgerBuilder` - builds a cheeseburger using the following ingredients: `RegularBun`, `Cheese`, `BeefPatty`, `Ketchup`, `Mustard`, `GrillSeasoning`, `Onions` and `PickleSlices`.

```dart
class CheeseburgerBuilder extends BurgerBuilderBase {
  CheeseburgerBuilder() {
    price = 1.09;
  }

  @override
  void addBuns() {
    burger.addIngredient(RegularBun());
  }

  @override
  void addCheese() {
    burger.addIngredient(Cheese());
  }

  @override
  void addPatties() {
    burger.addIngredient(BeefPatty());
  }

  @override
  void addSauces() {
    burger.addIngredient(Ketchup());
    burger.addIngredient(Mustard());
  }

  @override
  void addSeasoning() {
    burger.addIngredient(GrillSeasoning());
  }

  @override
  void addVegetables() {
    burger.addIngredient(Onions());
    burger.addIngredient(PickleSlices());
  }
}
```

- `HamburgerBuilder` - builds a cheeseburger using the following ingredients: `RegularBun`, `BeefPatty`, `Ketchup`, `Mustard`, `GrillSeasoning`, `Onions` and `PickleSlices`. `AddCheese()` method is not relevant for this builder, hence the implementation is not provided (skipped).

```dart
class HamburgerBuilder extends BurgerBuilderBase {
  HamburgerBuilder() {
    price = 1.0;
  }

  @override
  void addBuns() {
    burger.addIngredient(RegularBun());
  }

  @override
  void addCheese() {
    // Not needed
  }

  @override
  void addPatties() {
    burger.addIngredient(BeefPatty());
  }

  @override
  void addSauces() {
    burger.addIngredient(Ketchup());
    burger.addIngredient(Mustard());
  }

  @override
  void addSeasoning() {
    burger.addIngredient(GrillSeasoning());
  }

  @override
  void addVegetables() {
    burger.addIngredient(Onions());
    burger.addIngredient(PickleSlices());
  }
}
```

- `McChickenBuilder` - builds a cheeseburger using the following ingredients: `RegularBun`, `McChickenPatty`, `Mayonnaise` and `ShreddedLettuce`. `AddCheese()` and `addSeasoning()` methods are not relevant for this builder, hence the implementation is not provided (skipped).

```dart
class McChickenBuilder extends BurgerBuilderBase {
  McChickenBuilder() {
    price = 1.29;
  }

  @override
  void addBuns() {
    burger.addIngredient(RegularBun());
  }

  @override
  void addCheese() {
    // Not needed
  }

  @override
  void addPatties() {
    burger.addIngredient(McChickenPatty());
  }

  @override
  void addSauces() {
    burger.addIngredient(Mayonnaise());
  }

  @override
  void addSeasoning() {
    // Not needed
  }

  @override
  void addVegetables() {
    burger.addIngredient(ShreddedLettuce());
  }
}
```

### BurgerMaker

A director class that manages the burger's build process and returns the build result. A specific implementation of the builder is injected into the class via constructor.

```dart
class BurgerMaker {
  BurgerMaker(this.burgerBuilder);

  BurgerBuilderBase burgerBuilder;

  void changeBurgerBuilder(BurgerBuilderBase burgerBuilder) {
    this.burgerBuilder = burgerBuilder;
  }

  Burger getBurger() => burgerBuilder.getBurger();

  void prepareBurger() {
    burgerBuilder.createBurger();
    burgerBuilder.setBurgerPrice();

    burgerBuilder.addBuns();
    burgerBuilder.addCheese();
    burgerBuilder.addPatties();
    burgerBuilder.addSauces();
    burgerBuilder.addSeasoning();
    burgerBuilder.addVegetables();
  }
}
```

### Example

`BuilderExample` initialises and contains the `BurgerMaker` class object. Also, it contains a list of `BurgerMenuItem` objects/selection items which is used to select the specific builder using UI.

The director class `BurgerMaker` does not care about the specific implementation of the builder - the specific implementation could be changed at run-time, hence providing a different result. Also, this kind of implementation allows easily adding a new builder (as long as it extends the `BurgerBuilderBase` class) to provide another different product's representation without breaking the existing code.

```dart
class BuilderExample extends StatefulWidget {
  const BuilderExample();

  @override
  _BuilderExampleState createState() => _BuilderExampleState();
}

class _BuilderExampleState extends State<BuilderExample> {
  final _burgerMaker = BurgerMaker(HamburgerBuilder());
  final List<BurgerMenuItem> _burgerMenuItems = [];

  late BurgerMenuItem _selectedBurgerMenuItem;
  late Burger _selectedBurger;

  @override
  void initState() {
    super.initState();

    _burgerMenuItems.addAll([
      BurgerMenuItem(label: 'Hamburger', burgerBuilder: HamburgerBuilder()),
      BurgerMenuItem(
        label: 'Cheeseburger',
        burgerBuilder: CheeseburgerBuilder(),
      ),
      BurgerMenuItem(label: 'Big Mac\u00AE', burgerBuilder: BigMacBuilder()),
      BurgerMenuItem(
        label: 'McChicken\u00AE',
        burgerBuilder: McChickenBuilder(),
      ),
    ]);

    _selectedBurgerMenuItem = _burgerMenuItems[0];
    _selectedBurger = _prepareSelectedBurger();
  }

  Burger _prepareSelectedBurger() {
    _burgerMaker.prepareBurger();

    return _burgerMaker.getBurger();
  }

  void _onBurgerMenuItemChanged(BurgerMenuItem? selectedItem) => setState(() {
        _selectedBurgerMenuItem = selectedItem!;
        _burgerMaker.changeBurgerBuilder(selectedItem.burgerBuilder);
        _selectedBurger = _prepareSelectedBurger();
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Select menu item:',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            DropdownButton(
              value: _selectedBurgerMenuItem,
              items: _burgerMenuItems
                  .map<DropdownMenuItem<BurgerMenuItem>>(
                    (BurgerMenuItem item) => DropdownMenuItem(
                      value: item,
                      child: Text(item.label),
                    ),
                  )
                  .toList(),
              onChanged: _onBurgerMenuItemChanged,
            ),
            const SizedBox(height: LayoutConstants.spaceL),
            Row(
              children: <Widget>[
                Text(
                  'Information:',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: LayoutConstants.spaceM),
            BurgerInformationColumn(burger: _selectedBurger),
          ],
        ),
      ),
    );
  }
}
```
