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
            for (final (i, visitor) in visitorsList.indexed)
              RadioListTile<int>(
                title: Text(visitor.getTitle()),
                value: i,
                selected: i == selectedIndex,
              ),
          ],
        ),
      ),
    );
  }
}
