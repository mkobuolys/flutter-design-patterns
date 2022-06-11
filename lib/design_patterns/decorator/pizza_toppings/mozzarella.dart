import '../pizza_decorator.dart';

class Mozzarella extends PizzaDecorator {
  Mozzarella(super.pizza) {
    description = 'Mozzarella';
  }

  @override
  String getDescription() {
    return '${pizza.getDescription()}\n- $description';
  }

  @override
  double getPrice() {
    return pizza.getPrice() + 0.5;
  }
}
