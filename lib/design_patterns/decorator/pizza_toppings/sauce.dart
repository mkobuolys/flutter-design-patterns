import 'package:flutter_design_patterns/design_patterns/decorator/pizza.dart';
import 'package:flutter_design_patterns/design_patterns/decorator/pizza_decorator.dart';

class Sauce extends PizzaDecorator {
  Sauce(Pizza pizza) : super(pizza) {
    description = "Sauce";
  }

  @override
  String getDescription() {
    return "${pizza.getDescription()}, $description";
  }

  @override
  double getPrice() {
    return pizza.getPrice() + 0.3;
  }
}
