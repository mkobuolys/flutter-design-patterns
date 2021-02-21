import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/constants.dart';
import 'package:flutter_design_patterns/design_patterns/decorator/pizza_topping_data.dart';

class CustomPizzaSelection extends StatelessWidget {
  final Map<int, PizzaToppingData> pizzaToppingsDataMap;
  final Function onSelected;

  const CustomPizzaSelection({
    @required this.pizzaToppingsDataMap,
    @required this.onSelected,
  })  : assert(pizzaToppingsDataMap != null),
        assert(onSelected != null);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spaceM,
      children: <Widget>[
        for (var i = 0; i < pizzaToppingsDataMap.length; i++)
          i == 0
              ? ChoiceChip(
                  label: const Text(
                    'Pizza Base',
                    style: TextStyle(color: Colors.white),
                  ),
                  selected: true,
                  selectedColor: Colors.black,
                  onSelected: (_) {},
                )
              : ChoiceChip(
                  label: Text(
                    pizzaToppingsDataMap[i].label,
                    style: TextStyle(
                      color: pizzaToppingsDataMap[i].selected
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  selected: pizzaToppingsDataMap[i].selected,
                  selectedColor: Colors.black,
                  onSelected: (bool selected) => onSelected(i, selected),
                ),
      ],
    );
  }
}
