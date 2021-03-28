import 'package:flutter/material.dart';

import '../../../../design_patterns/observer/stock_subscriber.dart';

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
    return Column(
      children: <Widget>[
        for (var i = 0; i < stockSubscriberList.length; i++)
          RadioListTile(
            title: Text(stockSubscriberList[i].title),
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
