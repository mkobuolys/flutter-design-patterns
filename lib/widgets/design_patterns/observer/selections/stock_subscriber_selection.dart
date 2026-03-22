import 'package:flutter/material.dart';

import '../../../../design_patterns/observer/observer.dart';

class StockSubscriberSelection extends StatelessWidget {
  final List<StockSubscriber> stockSubscriberList;
  final int selectedIndex;
  final ValueSetter<int?> onChanged;

  const StockSubscriberSelection({
    required this.stockSubscriberList,
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
            for (final (i, subscriber) in stockSubscriberList.indexed)
              RadioListTile<int>(
                title: Text(subscriber.title),
                value: i,
                selected: i == selectedIndex,
              ),
          ],
        ),
      ),
    );
  }
}
