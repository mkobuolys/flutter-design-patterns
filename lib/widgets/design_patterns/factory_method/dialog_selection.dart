import 'package:flutter/material.dart';

import '../../../design_patterns/factory_method/factory_method.dart';

class DialogSelection extends StatelessWidget {
  final List<CustomDialog> customDialogList;
  final int selectedIndex;
  final ValueSetter<int?> onChanged;

  const DialogSelection({
    required this.customDialogList,
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
            for (final (i, dialog) in customDialogList.indexed)
              RadioListTile<int>(
                title: Text(dialog.getTitle()),
                value: i,
                selected: i == selectedIndex,
              ),
          ],
        ),
      ),
    );
  }
}
