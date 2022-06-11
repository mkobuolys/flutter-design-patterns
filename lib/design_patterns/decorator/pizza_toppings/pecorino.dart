import '../pizza_decorator.dart';

class Pecorino extends PizzaDecorator {
  Pecorino(super.pizza) {
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
