import 'package:flutter_design_patterns/design_patterns/decorator/pizza.dart';
import 'package:flutter_design_patterns/design_patterns/decorator/pizza_base.dart';
import 'package:flutter_design_patterns/design_patterns/decorator/pizza_topping_data.dart';
import 'package:flutter_design_patterns/design_patterns/decorator/pizza_toppings/basil.dart';
import 'package:flutter_design_patterns/design_patterns/decorator/pizza_toppings/mozzarella.dart';
import 'package:flutter_design_patterns/design_patterns/decorator/pizza_toppings/olive_oil.dart';
import 'package:flutter_design_patterns/design_patterns/decorator/pizza_toppings/oregano.dart';
import 'package:flutter_design_patterns/design_patterns/decorator/pizza_toppings/pecorino.dart';
import 'package:flutter_design_patterns/design_patterns/decorator/pizza_toppings/pepperoni.dart';
import 'package:flutter_design_patterns/design_patterns/decorator/pizza_toppings/sauce.dart';

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
