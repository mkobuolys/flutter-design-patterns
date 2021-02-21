import '../pizza.dart';
import '../pizza_decorator.dart';

class Sauce extends PizzaDecorator {
  Sauce(Pizza pizza) : super(pizza) {
    description = 'Sauce';
  }

  @override
  String getDescription() {
    return '${pizza.getDescription()}\n- $description';
  }

  @override
  double getPrice() {
    return pizza.getPrice() + 0.3;
  }
}
