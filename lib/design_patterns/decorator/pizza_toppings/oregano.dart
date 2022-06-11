import '../pizza_decorator.dart';

class Oregano extends PizzaDecorator {
  Oregano(super.pizza) {
    description = 'Oregano';
  }

  @override
  String getDescription() {
    return '${pizza.getDescription()}\n- $description';
  }

  @override
  double getPrice() {
    return pizza.getPrice() + 0.2;
  }
}
