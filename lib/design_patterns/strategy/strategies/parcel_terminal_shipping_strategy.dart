import 'package:flutter_design_patterns/design_patterns/strategy/ishipping_costs_strategy.dart';
import 'package:flutter_design_patterns/design_patterns/strategy/order/order.dart';
import 'package:flutter_design_patterns/design_patterns/strategy/order/order_item.dart';
import 'package:flutter_design_patterns/design_patterns/strategy/order/package_size.dart';

class ParcelTerminalShippingStrategy implements IShippingCostsStrategy {
  @override
  String label = 'Parcel terminal shipping';

  @override
  double calculate(Order order) {
    var finalShippingPrice = 0.0;

    for (var item in order.items) {
      finalShippingPrice += _getOrderItemShippingPrice(item);
    }

    return finalShippingPrice;
  }

  double _getOrderItemShippingPrice(OrderItem orderItem) {
    switch (orderItem.packageSize) {
      case PackageSize.S:
        return 1.99;
      case PackageSize.M:
        return 2.49;
      case PackageSize.L:
        return 2.99;
      case PackageSize.XL:
        return 3.49;
      default:
        throw new Exception(
            "Unknown shipping price for the package of size '${orderItem.packageSize}'.");
    }
  }
}
