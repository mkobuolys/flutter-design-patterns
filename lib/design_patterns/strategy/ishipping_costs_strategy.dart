import 'order/order.dart';

abstract class IShippingCostsStrategy {
  String label;
  double calculate(Order order);
}
