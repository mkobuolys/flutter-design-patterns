import 'package:flutter/material.dart';

const _labels = ['Pizza Margherita', 'Pizza Pepperoni', 'Custom'];

class PizzaSelection extends StatelessWidget {
  final int selectedIndex;
  final ValueSetter<int?> onChanged;

  const PizzaSelection({
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (final (i, label) in _labels.indexed)
          RadioListTile(
            title: Text(label),
            value: i,
            groupValue: selectedIndex,
            selected: i == selectedIndex,
            activeColor: Colors.black,
            onChanged: onChanged,
          ),
      ],
    );
  }
}
