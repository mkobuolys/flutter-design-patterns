## Class diagram

![Builder Class Diagram](resource:assets/images/builder/builder.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of **Builder** design pattern.

![Builder Implementation Class Diagram](resource:assets/images/builder/builder_implementation.png)

The _Ingredient_ is an abstract class which is used as a base class for all the ingredient classes. The class contains _allergens_ and _name_ properties as well as _getAllergens()_ and _getName()_ methods to return values of these properties.

There are a lot of concrete ingredient classes: _BigMacBun_, _RegularBun_, _BeefPatty_, _McChickenPatty_, _BigMacSauce_, _Ketchup_, _Mayonnaise_, _Mustard_, _Onions_, _PickleSlices_, _ShreddedLettuce_, _Cheese_ and _GrillSeasoning_. All of these classes represent a specific ingredient of a burger and contains a default constructor to set the _allergens_ and _name_ property values of the base class.

_Burger_ is a simple class representing the product of a builder. It contains _ingredients_ list and _price_ property to store the corresponding values. Also, the class contains several methods:

- _addIngredient()_ - adds an ingredient to the burger;
- _getFormattedIngredients()_ - returns a formatted ingredients' list of a burger (separated by commas);
- _getFormattedAllergens()_ - returns a formatted allergens' list of a burger (separated by commas);
- _getFormattedPrice()_ - returns a formatted price of a burger;
- _setPrice()_ - sets the price for the burger.

_BurgerBuilderBase_ is an abstract class which is used as a base class for all the burger builder classes. It contains _burger_ and _price_ properties to store the final product - burger - and its price correspondingly. Additionally, the class stores some methods with default implementation:

- _createBurger()_ - initialises a _Burger_ class object;
- _getBurger()_ - returns the built burger result;
- _setBurgerPrice()_ - sets the price for the burger object.

_BurgerBuilderBase_ also contain several abstract methods which must be implemented in the specific implementation classes of the burger builder: _addBuns()_, _addCheese()_, _addPatties()_, _addSauces()_, _addSeasoning()_ and _addVegetables()_.

_BigMacBuilder_, _CheeseburgerBuilder_, _HamburgerBuilder_ and _McChickenBuilder_ are concrete builder classes which extend the abstract class _BurgerBuilderBase_ and implement its abstract methods.

_BurgerMaker_ is director class which manages the burger's build process. It contains a specific builder implementation as a _burgerBuilder_ property, _prepareBurger()_ method to build the burger and a _getBurger()_ method to return it. Also, the builder's implementation could be changed using the _changeBurgerBuilder()_ method.

_BuilderExample_ initialises and contains the _BurgerMaker_ class. Also, it references all the specific burger builders which could be changed at run-time using the UI dropdown selection.

### Ingredient

An abstract class which stores the _allergens_, _name_ fields and is extended by all of the ingredient classes.

```
abstract class Ingredient {
  @protected
  List<String> allergens;
  @protected
  String name;

  List<String> getAllergens() {
    return allergens;
  }

  String getName() {
    return name;
  }
}
```

### Concrete ingredients

All of these classes represent a specific ingredient by extending the _Ingredient_ class and specifying an allergens' list as well as the name value.

```
class BigMacBun extends Ingredient {
  BigMacBun() {
    name = 'Big Mac Bun';
    allergens = ['Wheat'];
  }
}
```

```
class RegularBun extends Ingredient {
  RegularBun() {
    name = 'Regular Bun';
    allergens = ['Wheat'];
  }
}
```

```
class BeefPatty extends Ingredient {
  BeefPatty() {
    name = 'Beef Patty';
    allergens = [];
  }
}
```

```
class McChickenPatty extends Ingredient {
  McChickenPatty() {
    name = 'McChicken Patty';
    allergens = [
      'Wheat',
      'Cooked in the same fryer that we use for Buttermilk Crispy Chicken which contains a milk allergen'
    ];
  }
}
```

```
class BigMacSauce extends Ingredient {
  BigMacSauce() {
    name = 'Big Mac Sauce';
    allergens = ['Egg', 'Soy', 'Wheat'];
  }
}
```

```
class Ketchup extends Ingredient {
  Ketchup() {
    name = 'Ketchup';
    allergens = [];
  }
}
```

```
class Mayonnaise extends Ingredient {
  Mayonnaise() {
    name = 'Mayonnaise';
    allergens = ['Egg'];
  }
}
```

```
class Mustard extends Ingredient {
  Mustard() {
    name = 'Mustard';
    allergens = [];
  }
}
```

```
class Onions extends Ingredient {
  Onions() {
    name = 'Onions';
    allergens = [];
  }
}
```

```
class PickleSlices extends Ingredient {
  PickleSlices() {
    name = 'Pickle Slices';
    allergens = [];
  }
}
```

```
class ShreddedLettuce extends Ingredient {
  ShreddedLettuce() {
    name = 'Shredded Lettuce';
    allergens = [];
  }
}
```

```
class Cheese extends Ingredient {
  Cheese() {
    name = 'Cheese';
    allergens = ['Milk', 'Soy'];
  }
}
```

```
class GrillSeasoning extends Ingredient {
  GrillSeasoning() {
    name = 'Grill Seasoning';
    allergens = [];
  }
}
```

### Burger

A simple class to store information about the burger: its price and a list of ingredients it contains. Also, class methods, such as _getFormattedIngredients()_, _getFormattedAllergens()_ and _getFormattedPrice()_, returns these values in human-readable format.

```
class Burger {
  final List<Ingredient> _ingredients = [];
  double _price;

  void addIngredient(Ingredient ingredient) {
    _ingredients.add(ingredient);
  }

  String getFormattedIngredients() {
    return _ingredients.map((x) => x.getName()).join(', ');
  }

  String getFormattedAllergens() {
    var allergens = Set<String>();

    _ingredients.forEach((x) => allergens.addAll(x.getAllergens()));

    return allergens.join(', ');
  }

  String getFormattedPrice() {
    return '\$${_price.toStringAsFixed(2)}';
  }

  void setPrice(double price) {
    _price = price;
  }
}
```

### BurgerBuilderBase

An abstract class which stores _burger_ and _price_ properties, defines some default methods to create/return the burger object and set its price. Also, the class defines several abstract methods which must be implemented by the derived burger builder classes.

```
abstract class BurgerBuilderBase {
  @protected
  Burger burger;
  @protected
  double price;

  void createBurger() {
    burger = Burger();
  }

  Burger getBurger() {
    return burger;
  }

  void setBurgerPrice() {
    burger.setPrice(price);
  }

  void addBuns();
  void addCheese();
  void addPatties();
  void addSauces();
  void addSeasoning();
  void addVegetables();
}

```

### Concrete builders

- _BigMacBuilder_ - builds a Big Mac using the following ingredients: _BigMacBun_, _Cheese_, _BeefPatty_, _BigMacSauce_, _GrillSeasoning_, _Onions_, _PickleSlices_ and _ShreddedLettuce_.

```
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

- _CheeseburgerBuilder_ - builds a cheeseburger using the following ingredients: _RegularBun_, _Cheese_, _BeefPatty_, _Ketchup_, _Mustard_, _GrillSeasoning_, _Onions_ and _PickleSlices_.

```
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

- _HamburgerBuilder_ - builds a cheeseburger using the following ingredients: _RegularBun_, _BeefPatty_, _Ketchup_, _Mustard_, _GrillSeasoning_, _Onions_ and _PickleSlices_. _AddCheese()_ method is not relevant for this builder, hence the implementation is not provided (skipped).

```
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

- _McChickenBuilder_ - builds a cheeseburger using the following ingredients: _RegularBun_, _McChickenPatty_, _Mayonnaise_ and _ShreddedLettuce_. _AddCheese()_ and _addSeasoning()_ methods are not relevant for this builder, hence the implementation is not provided (skipped).

```
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

A director class which manages the burger's build process and returns the build result. A specific implementation of the builder is injected into the class via constructor.

```
class BurgerMaker {
  BurgerBuilderBase burgerBuilder;

  BurgerMaker(this.burgerBuilder);

  void changeBurgerBuilder(BurgerBuilderBase burgerBuilder) {
    this.burgerBuilder = burgerBuilder;
  }

  Burger getBurger() {
    return burgerBuilder.getBurger();
  }

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

_BuilderExample_ initialises and contains the _BurgerMaker_ class object. Also, it contains a list of _BurgerMenuItem_ objects/selection items which is used to select the specific builder using UI.

The director class _BurgerMaker_ does not care about the specific implementation of the builder - the specific implementation could be changed at run-time, hence providing a different result. Also, this kind of implementation allows easily adding a new builder (as long as it extends the _BurgerBuilderBase_ class) to provide another different product's representation without breaking the existing code.

```
class BuilderExample extends StatefulWidget {
  @override
  _BuilderExampleState createState() => _BuilderExampleState();
}

class _BuilderExampleState extends State<BuilderExample> {
  final BurgerMaker _burgerMaker = BurgerMaker(HamburgerBuilder());
  final List<BurgerMenuItem> _burgerMenuItems = [];

  BurgerMenuItem _selectedBurgerMenuItem;
  Burger _selectedBurger;

  @override
  void initState() {
    super.initState();

    _burgerMenuItems.addAll([
      BurgerMenuItem(
        label: 'Hamburger',
        burgerBuilder: HamburgerBuilder(),
      ),
      BurgerMenuItem(
        label: 'Cheeseburger',
        burgerBuilder: CheeseburgerBuilder(),
      ),
      BurgerMenuItem(
        label: 'Big Mac\u00AE',
        burgerBuilder: BigMacBuilder(),
      ),
      BurgerMenuItem(
        label: 'McChicken\u00AE',
        burgerBuilder: McChickenBuilder(),
      )
    ]);

    _selectedBurgerMenuItem = _burgerMenuItems[0];
    _selectedBurger = _prepareSelectedBurger();
  }

  Burger _prepareSelectedBurger() {
    _burgerMaker.prepareBurger();

    return _burgerMaker.getBurger();
  }

  void _onBurgerMenuItemChanged(BurgerMenuItem selectedItem) {
    setState(() {
      _selectedBurgerMenuItem = selectedItem;
      _burgerMaker.changeBurgerBuilder(selectedItem.burgerBuilder);
      _selectedBurger = _prepareSelectedBurger();
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
            Row(
              children: <Widget>[
                Text(
                  'Select menu item:',
                  style: Theme.of(context).textTheme.headline6,
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
            SizedBox(height: spaceL),
            Row(
              children: <Widget>[
                Text(
                  'Information:',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
            SizedBox(height: spaceM),
            BurgerInformationColumn(burger: _selectedBurger),
          ],
        ),
      ),
    );
  }
}
```
