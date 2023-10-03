import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';
import '../../../../design_patterns/strategy/strategy.dart';

class OrderItemsTable extends StatelessWidget {
  final List<OrderItem> orderItems;

  const OrderItemsTable({
    required this.orderItems,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: LayoutConstants.spaceL,
      horizontalMargin: LayoutConstants.marginM,
      headingRowHeight: LayoutConstants.spaceXL,
      dataRowMinHeight: LayoutConstants.spaceXL,
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Title',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
          ),
        ),
        DataColumn(
          label: Text(
            'Package Size',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
          ),
        ),
        DataColumn(
          label: Text(
            'Price',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
          ),
          numeric: true,
        ),
      ],
      rows: <DataRow>[
        for (final orderItem in orderItems)
          DataRow(
            cells: <DataCell>[
              DataCell(Text(orderItem.title)),
              DataCell(Text(orderItem.packageSize.toString().split('.').last)),
              DataCell(Text('\$${orderItem.price.toStringAsFixed(2)}')),
            ],
          ),
      ],
    );
  }
}
