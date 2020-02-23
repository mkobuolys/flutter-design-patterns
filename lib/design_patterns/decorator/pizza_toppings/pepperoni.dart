import 'package:flutter_design_patterns/design_patterns/decorator/pizza.dart';
import 'package:flutter_design_patterns/design_patterns/decorator/pizza_decorator.dart';

class Pepperoni extends PizzaDecorator {
  Pepperoni(Pizza pizza) : super(pizza) {
    description = "Pepperoni";
  }

  @override
  String getDescription() {
    return "${pizza.getDescription()}, $description";
  }

  @override
  double getPrice() {
    return pizza.getPrice() + 1.5;
  }
}
