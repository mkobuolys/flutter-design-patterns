import 'package:flutter_design_patterns/design_patterns/decorator/pizza.dart';
import 'package:flutter_design_patterns/design_patterns/decorator/pizza_base.dart';
import 'package:flutter_design_patterns/design_patterns/decorator/pizza_toppings/basil.dart';
import 'package:flutter_design_patterns/design_patterns/decorator/pizza_toppings/mozzarella.dart';
import 'package:flutter_design_patterns/design_patterns/decorator/pizza_toppings/olive_oil.dart';
import 'package:flutter_design_patterns/design_patterns/decorator/pizza_toppings/oregano.dart';
import 'package:flutter_design_patterns/design_patterns/decorator/pizza_toppings/pecorino.dart';
import 'package:flutter_design_patterns/design_patterns/decorator/pizza_toppings/pepperoni.dart';
import 'package:flutter_design_patterns/design_patterns/decorator/pizza_toppings/sauce.dart';

class PizzaMenu {
  Pizza getMargherita() {
    Pizza pizza = PizzaBase("Pizza Margherita");
    pizza = Sauce(pizza);
    pizza = Mozzarella(pizza);
    pizza = Basil(pizza);
    pizza = Oregano(pizza);
    pizza = Pecorino(pizza);
    pizza = OliveOil(pizza);

    return pizza;
  }

  Pizza getPepperoni() {
    Pizza pizza = PizzaBase("Pizza Pepperoni");
    pizza = Sauce(pizza);
    pizza = Mozzarella(pizza);
    pizza = Pepperoni(pizza);
    pizza = Oregano(pizza);

    return pizza;
  }
}
