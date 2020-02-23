import 'package:flutter_design_patterns/design_patterns/decorator/pizza.dart';
import 'package:flutter_design_patterns/design_patterns/decorator/pizza_decorator.dart';

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
