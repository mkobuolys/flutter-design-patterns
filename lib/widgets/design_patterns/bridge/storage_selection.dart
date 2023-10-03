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
    return Column(
      children: <Widget>[
        for (final (i, storage) in storages.indexed)
          RadioListTile(
            title: Text(storage.getTitle()),
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
