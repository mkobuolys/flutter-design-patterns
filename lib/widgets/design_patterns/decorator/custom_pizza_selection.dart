import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../design_patterns/decorator/decorator.dart';

class CustomPizzaSelection extends StatelessWidget {
  final Map<int, PizzaToppingData> pizzaToppingsDataMap;
  final Function(int, bool?) onSelected;

  const CustomPizzaSelection({
    required this.pizzaToppingsDataMap,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: LayoutConstants.spaceM,
      runSpacing: LayoutConstants.spaceM,
      children: <Widget>[
        for (var i = 0; i < pizzaToppingsDataMap.length; i++)
          i == 0
              ? _ChoiceChip(
                  label: 'Pizza Base',
                  selected: true,
                  onSelected: (_) {},
                )
              : _ChoiceChip(
                  label: pizzaToppingsDataMap[i]!.label,
                  selected: pizzaToppingsDataMap[i]!.selected,
                  onSelected: (bool? selected) => onSelected(i, selected),
                ),
      ],
    );
  }
}

class _ChoiceChip extends StatelessWidget {
  const _ChoiceChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final ValueSetter<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    final color = selected ? Colors.white : Colors.black;

    return ChoiceChip(
      color: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.black;
        }

        return Colors.white;
      }),
      label: Text(label),
      labelStyle: TextStyle(color: color),
      checkmarkColor: color,
      selected: selected,
      onSelected: onSelected,
    );
  }
}
