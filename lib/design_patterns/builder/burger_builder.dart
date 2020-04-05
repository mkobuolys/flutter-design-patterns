import 'package:flutter_design_patterns/design_patterns/builder/burger.dart';
import 'package:flutter_design_patterns/design_patterns/builder/ingredients/index.dart';

class BurgerBuilder {
  Burger prepareHamburger() {
    var burger = Burger(price: 1);

    burger.addIngredient(RegularBun());
    burger.addIngredient(BeefPatty());
    burger.addIngredient(Ketchup());
    burger.addIngredient(PickleSlices());
    burger.addIngredient(Onions());
    burger.addIngredient(Mustard());
    burger.addIngredient(GrillSeasoning());

    return burger;
  }

  Burger prepareCheeseburger() {
    var burger = Burger(price: 1.09);

    burger.addIngredient(RegularBun());
    burger.addIngredient(BeefPatty());
    burger.addIngredient(Cheese());
    burger.addIngredient(Ketchup());
    burger.addIngredient(PickleSlices());
    burger.addIngredient(Onions());
    burger.addIngredient(Mustard());
    burger.addIngredient(GrillSeasoning());

    return burger;
  }

  Burger prepareBigMac() {
    var burger = Burger(price: 3.99);

    burger.addIngredient(BigMacBun());
    burger.addIngredient(BeefPatty());
    burger.addIngredient(ShreddedLettuce());
    burger.addIngredient(BigMacSauce());
    burger.addIngredient(Cheese());
    burger.addIngredient(PickleSlices());
    burger.addIngredient(Onions());
    burger.addIngredient(GrillSeasoning());

    return burger;
  }

  Burger prepareMcChicken() {
    var burger = Burger(price: 1.29);

    burger.addIngredient(RegularBun());
    burger.addIngredient(McChickenPatty());
    burger.addIngredient(ShreddedLettuce());
    burger.addIngredient(Mayonnaise());

    return burger;
  }
}
