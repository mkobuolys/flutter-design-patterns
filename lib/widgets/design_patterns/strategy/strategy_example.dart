import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/constants.dart';
import 'package:flutter_design_patterns/design_patterns/strategy/ishipping_costs_strategy.dart';
import 'package:flutter_design_patterns/design_patterns/strategy/order/order.dart';
import 'package:flutter_design_patterns/design_patterns/strategy/order/order_item.dart';
import 'package:flutter_design_patterns/design_patterns/strategy/strategies/in_store_pickup_strategy.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/strategy/order_items_table.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/strategy/order_summary.dart';
import 'package:flutter_design_patterns/widgets/platform_specific/platform_button.dart';

class StrategyExample extends StatefulWidget {
  @override
  _StrategyExampleState createState() => _StrategyExampleState();
}

class _StrategyExampleState extends State<StrategyExample> {
  final Order order = Order();
  IShippingCostsStrategy shippingCostsStrategy = InStorePickupStrategy();

  void _addToOrder() {
    setState(() {
      order.addOrderItem(OrderItem.random());
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            PlatformButton(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  const SizedBox(width: spaceXS),
                  Text('Add random item'),
                ],
              ),
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _addToOrder,
            ),
            if (order.items.length == 0)
              Text(
                'You have not added any items to your order.',
                style: Theme.of(context).textTheme.subhead,
              ),
            if (order.items.length > 0)
              OrderItemsTable(
                orderItems: order.items,
              ),
            OrderSummary(
              shippingCostsStrategy: shippingCostsStrategy,
              order: order,
            ),
          ],
        ),
      ),
    );
  }
}
