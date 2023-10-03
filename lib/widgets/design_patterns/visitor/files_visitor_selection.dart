import 'package:flutter/material.dart';

import '../../../design_patterns/visitor/visitor.dart';

class FilesVisitorSelection extends StatelessWidget {
  const FilesVisitorSelection({
    required this.visitorsList,
    required this.selectedIndex,
    required this.onChanged,
  });

  final List<IVisitor> visitorsList;
  final int selectedIndex;
  final ValueSetter<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (final (i, visitor) in visitorsList.indexed)
          RadioListTile(
            title: Text(visitor.getTitle()),
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
