import 'order/order.dart';

abstract interface class IShippingCostsStrategy {
  late String label;
  double calculate(Order order);
}
