import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/design_patterns/abstract_factory/iwidgets_factory.dart';

class FactorySelection extends StatelessWidget {
  final List<IWidgetsFactory> widgetsFactoryList;
  final int selectedIndex;
  final ValueSetter<int> onChanged;

  const FactorySelection({
    @required this.widgetsFactoryList,
    @required this.selectedIndex,
    @required this.onChanged,
  })  : assert(widgetsFactoryList != null),
        assert(selectedIndex != null),
        assert(onChanged != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (var i = 0; i < widgetsFactoryList.length; i++)
          RadioListTile(
            title: Text(widgetsFactoryList[i].getTitle()),
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
