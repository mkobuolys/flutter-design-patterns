import 'dart:math';

import 'package:flutter/widgets.dart';

import '../../../design_patterns/flyweight/flyweight.dart';

class PositionedShapeWrapper extends StatelessWidget {
  final IPositionedShape shape;

  const PositionedShapeWrapper({
    required this.shape,
  });

  double _getPosition(double max, double min) {
    final randomPosition = Random().nextDouble() * max;

    return randomPosition > min ? randomPosition - min : randomPosition;
  }

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWidth = MediaQuery.of(context).size.width;

    return shape.render(
      _getPosition(sizeWidth, 16.0),
      _getPosition(sizeHeight, 192.0),
    );
  }
}
