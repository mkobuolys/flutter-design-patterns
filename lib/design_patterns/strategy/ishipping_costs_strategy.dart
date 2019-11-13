import 'package:flutter_design_patterns/design_patterns/strategy/order/order.dart';

abstract class IShippingCostsStrategy {
  String label;
  double calculate(Order order);
}
