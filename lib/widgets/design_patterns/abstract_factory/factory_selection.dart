import 'package:flutter/material.dart';

import '../../../design_patterns/abstract_factory/abstract_factory.dart';

class FactorySelection extends StatelessWidget {
  final List<IWidgetsFactory> widgetsFactoryList;
  final int selectedIndex;
  final ValueSetter<int?> onChanged;

  const FactorySelection({
    required this.widgetsFactoryList,
    required this.selectedIndex,
    required this.onChanged,
  });

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
            for (final (i, widgetsFactory) in widgetsFactoryList.indexed)
              RadioListTile<int>(
                title: Text(widgetsFactory.getTitle()),
                value: i,
                selected: i == selectedIndex,
              ),
          ],
        ),
      ),
    );
  }
}
