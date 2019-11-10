import 'package:flutter_design_patterns/design_patterns/strategy/ishipping_costs_strategy.dart';
import 'package:flutter_design_patterns/design_patterns/strategy/order/order.dart';

class InStorePickupStrategy implements IShippingCostsStrategy {
  @override
  double calculate(Order order) {
    return 0.0;
  }
}
