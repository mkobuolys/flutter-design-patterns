import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';
import '../../../../design_patterns/bridge/bridge.dart';

class OrdersDatatable extends StatelessWidget {
  final List<Order> orders;

  const OrdersDatatable({
    required this.orders,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: LayoutConstants.spaceM,
        horizontalMargin: LayoutConstants.marginM,
        headingRowHeight: LayoutConstants.spaceXL,
        dataRowMinHeight: LayoutConstants.spaceXL,
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'Dishes',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
            ),
          ),
          DataColumn(
            label: Text(
              'Total',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
            ),
            numeric: true,
          ),
        ],
        rows: <DataRow>[
          for (final order in orders)
            DataRow(
              cells: <DataCell>[
                DataCell(Text(order.dishes.join(', '))),
                DataCell(Text(order.total.toStringAsFixed(2))),
              ],
            ),
        ],
      ),
    );
  }
}
