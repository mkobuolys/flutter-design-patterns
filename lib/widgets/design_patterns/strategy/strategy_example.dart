import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../design_patterns/strategy/strategy.dart';
import 'order/order_buttons/order_buttons.dart';
import 'order/order_items_table.dart';
import 'order/order_summary/order_summary.dart';
import 'shipping_options.dart';

class StrategyExample extends StatefulWidget {
  const StrategyExample();

  @override
  _StrategyExampleState createState() => _StrategyExampleState();
}

class _StrategyExampleState extends State<StrategyExample> {
  final List<IShippingCostsStrategy> _shippingCostsStrategyList = [
    InStorePickupStrategy(),
    ParcelTerminalShippingStrategy(),
    PriorityShippingStrategy(),
  ];
  var _selectedStrategyIndex = 0;
  var _order = Order();

  void _addToOrder() => setState(() => _order.addOrderItem(OrderItem.random()));

  void _clearOrder() => setState(() => _order = Order());

  void _setSelectedStrategyIndex(int? index) {
    if (index == null) return;

    setState(() => _selectedStrategyIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: LayoutConstants.paddingL,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            OrderButtons(
              onAdd: _addToOrder,
              onClear: _clearOrder,
            ),
            const SizedBox(height: LayoutConstants.spaceM),
            Column(
              children: <Widget>[
                if (_order.items.isEmpty)
                  Text(
                    'Your order is empty',
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                else
                  OrderItemsTable(orderItems: _order.items),
                const SizedBox(height: LayoutConstants.spaceM),
                ShippingOptions(
                  selectedIndex: _selectedStrategyIndex,
                  shippingOptions: _shippingCostsStrategyList,
                  onChanged: _setSelectedStrategyIndex,
                ),
                OrderSummary(
                  shippingCostsStrategy:
                      _shippingCostsStrategyList[_selectedStrategyIndex],
                  order: _order,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
