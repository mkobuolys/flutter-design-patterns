import 'package:flutter_design_patterns/design_patterns/decorator/pizza.dart';
import 'package:flutter_design_patterns/design_patterns/decorator/pizza_decorator.dart';

class Basil extends PizzaDecorator {
  Basil(Pizza pizza) : super(pizza) {
    description = "Basil";
  }

  @override
  String getDescription() {
    return "${pizza.getDescription()}, $description";
  }

  @override
  double getPrice() {
    return pizza.getPrice() + 0.2;
  }
}
