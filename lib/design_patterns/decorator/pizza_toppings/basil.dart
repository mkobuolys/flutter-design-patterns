import '../pizza.dart';
import '../pizza_decorator.dart';

class Basil extends PizzaDecorator {
  Basil(Pizza pizza) : super(pizza) {
    description = 'Basil';
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
