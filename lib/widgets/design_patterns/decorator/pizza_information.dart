import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/constants.dart';
import 'package:flutter_design_patterns/design_patterns/decorator/pizza.dart';

class PizzaInformation extends StatelessWidget {
  final Pizza pizza;

  const PizzaInformation({
    @required this.pizza,
  }) : assert(pizza != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          'Pizza details:',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: spaceL),
        Text(
          pizza.getDescription(),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: spaceM),
        Text('Price: \$${pizza.getPrice().toStringAsFixed(2)}'),
      ],
    );
  }
}
