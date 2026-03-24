import 'package:flutter/material.dart';

import '../../../design_patterns/iterator/iterator.dart';

class TreeCollectionSelection extends StatelessWidget {
  final List<ITreeCollection> treeCollections;
  final int selectedIndex;
  final ValueSetter<int?>? onChanged;

  const TreeCollectionSelection({required this.treeCollections, required this.selectedIndex, required this.onChanged});

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
        onChanged: onChanged ?? (_) {},
        child: Column(
          children: <Widget>[
            for (final (i, collection) in treeCollections.indexed)
              RadioListTile<int>(title: Text(collection.getTitle()), value: i, selected: i == selectedIndex),
          ],
        ),
      ),
    );
  }
}
