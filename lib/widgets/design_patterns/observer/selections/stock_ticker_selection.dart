import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';
import '../stock_ticker_model.dart';

class StockTickerSelection extends StatelessWidget {
  final List<StockTickerModel> stockTickers;
  final ValueChanged<int> onChanged;

  const StockTickerSelection({
    required this.stockTickers,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        for (final (i, stockTickerModel) in stockTickers.indexed)
          Expanded(
            child: _TickerTile(
              stockTickerModel: stockTickerModel,
              index: i,
              onChanged: onChanged,
            ),
          ),
      ],
    );
  }
}

class _TickerTile extends StatelessWidget {
  final StockTickerModel stockTickerModel;
  final int index;
  final ValueChanged<int> onChanged;

  const _TickerTile({
    required this.stockTickerModel,
    required this.index,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: stockTickerModel.subscribed ? Colors.black : Colors.white,
      child: InkWell(
        onTap: () => onChanged(index),
        child: Padding(
          padding: const EdgeInsets.all(LayoutConstants.paddingM),
          child: Text(
            stockTickerModel.stockTicker.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: stockTickerModel.subscribed ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
