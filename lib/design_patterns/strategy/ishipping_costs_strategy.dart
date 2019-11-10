import 'package:flutter_design_patterns/design_patterns/strategy/order/order.dart';

abstract class IShippingCostsStrategy {
  double calculate(Order order);
}
