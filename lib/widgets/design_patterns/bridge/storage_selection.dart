import 'package:flutter/material.dart';

import '../../../design_patterns/bridge/bridge.dart';

class StorageSelection extends StatelessWidget {
  final List<IStorage> storages;
  final int selectedIndex;
  final ValueSetter<int?> onChanged;

  const StorageSelection({
    required this.storages,
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
            for (final (i, storage) in storages.indexed)
              RadioListTile<int>(
                title: Text(storage.getTitle()),
                value: i,
                selected: i == selectedIndex,
              ),
          ],
        ),
      ),
    );
  }
}
