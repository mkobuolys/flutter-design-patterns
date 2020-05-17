import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OrderSummaryRow extends StatelessWidget {
  final String label;
  final double value;
  final String fontFamily;

  const OrderSummaryRow({
    @required this.label,
    @required this.value,
    @required this.fontFamily,
  })  : assert(label != null),
        assert(value != null),
        assert(fontFamily != null);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(label,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(fontFamily: fontFamily)),
        Text('\$${value.toStringAsFixed(2)}',
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(fontFamily: fontFamily)),
      ],
    );
  }
}
