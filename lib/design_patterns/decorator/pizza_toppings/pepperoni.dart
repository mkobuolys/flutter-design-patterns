import '../pizza_decorator.dart';

class Pepperoni extends PizzaDecorator {
  Pepperoni(super.pizza) {
    description = 'Pepperoni';
  }

  @override
  String getDescription() {
    return '${pizza.getDescription()}\n- $description';
  }

  @override
  double getPrice() {
    return pizza.getPrice() + 1.5;
  }
}
