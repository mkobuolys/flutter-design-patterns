import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_design_patterns/design_patterns/flyweight/ipositioned_shape.dart';

class PositionedShapeWrapper extends StatelessWidget {
  final IPositionedShape shape;

  const PositionedShapeWrapper({
    @required this.shape,
  }) : assert(shape != null);

  double _getPosition(double max, double min) {
    var randomPosition = Random().nextDouble() * max;

    return randomPosition > min ? randomPosition - min : randomPosition;
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;

    return shape.render(
      _getPosition(sizeWidth, 16.0),
      _getPosition(sizeHeight, 192.0),
    );
  }
}
