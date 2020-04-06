import 'package:meta/meta.dart';

import 'package:flutter_design_patterns/design_patterns/builder/burger.dart';

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
