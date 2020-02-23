import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PizzaSelection extends StatelessWidget {
  final List<String> labels = ['Pizza Margherita', 'Pizza Pepperoni', 'Custom'];
  final int selectedIndex;
  final ValueSetter<int> onChanged;

  PizzaSelection({
    @required this.selectedIndex,
    @required this.onChanged,
  })  : assert(selectedIndex != null),
        assert(onChanged != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (var i = 0; i < labels.length; i++)
          RadioListTile(
            title: Text(labels[i]),
            value: i,
            groupValue: selectedIndex,
            selected: i == selectedIndex,
            activeColor: Colors.black,
            controlAffinity: ListTileControlAffinity.platform,
            onChanged: onChanged,
          ),
      ],
    );
  }
}
