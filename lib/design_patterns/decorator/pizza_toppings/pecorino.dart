import '../pizza.dart';
import '../pizza_decorator.dart';

class Pecorino extends PizzaDecorator {
  Pecorino(Pizza pizza) : super(pizza) {
    description = 'Pecorino';
  }

  @override
  String getDescription() {
    return '${pizza.getDescription()}\n- $description';
  }

  @override
  double getPrice() {
    return pizza.getPrice() + 0.7;
  }
}
