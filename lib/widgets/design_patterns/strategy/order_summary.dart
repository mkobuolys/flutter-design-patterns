import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/design_patterns/strategy/ishipping_costs_strategy.dart';
import 'package:flutter_design_patterns/design_patterns/strategy/order/order.dart';

class OrderSummary extends StatelessWidget {
  final Order order;
  final IShippingCostsStrategy shippingCostsStrategy;

  const OrderSummary({
    @required this.order,
    @required this.shippingCostsStrategy,
  })  : assert(order != null),
        assert(shippingCostsStrategy != null);

  @override
  Widget build(BuildContext context) {
    return Card();
  }
}
