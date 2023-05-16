import '../ishipping_costs_strategy.dart';
import '../order/order.dart';

class InStorePickupStrategy implements IShippingCostsStrategy {
  @override
  String label = 'In-store pickup';

  @override
  double calculate(Order order) => 0.0;
}
