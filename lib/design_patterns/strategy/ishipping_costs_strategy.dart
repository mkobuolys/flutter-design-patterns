import 'order/order.dart';

abstract class IShippingCostsStrategy {
  late String label;
  double calculate(Order order);
}
