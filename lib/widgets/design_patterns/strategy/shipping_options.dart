import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../design_patterns/strategy/strategy.dart';

class ShippingOptions extends StatelessWidget {
  final List<IShippingCostsStrategy> shippingOptions;
  final int selectedIndex;
  final ValueChanged<int?> onChanged;

  const ShippingOptions({required this.shippingOptions, required this.selectedIndex, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(LayoutConstants.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Select shipping type:', style: Theme.of(context).textTheme.titleMedium),
            RadioTheme(
              data: RadioThemeData(
                fillColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return Colors.black;
                  }
                  return Colors.black;
                }),
              ),
              child: RadioGroup<int>(
                groupValue: selectedIndex,
                onChanged: onChanged,
                child: Column(
                  children: [
                    for (final (i, option) in shippingOptions.indexed)
                      RadioListTile<int>(title: Text(option.label), value: i, dense: true),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
