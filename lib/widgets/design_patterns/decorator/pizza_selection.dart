import 'package:flutter/material.dart';

const _labels = ['Pizza Margherita', 'Pizza Pepperoni', 'Custom'];

class PizzaSelection extends StatelessWidget {
  final int selectedIndex;
  final ValueSetter<int?> onChanged;

  const PizzaSelection({required this.selectedIndex, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return RadioTheme(
      data: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.black;
          }
          return null;
        }),
      ),
      child: RadioGroup<int>(
        groupValue: selectedIndex,
        onChanged: onChanged,
        child: Column(
          children: <Widget>[
            for (final (i, label) in _labels.indexed)
              RadioListTile<int>(title: Text(label), value: i, selected: i == selectedIndex),
          ],
        ),
      ),
    );
  }
}
