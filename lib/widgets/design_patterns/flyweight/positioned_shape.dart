import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_design_patterns/design_patterns/flyweight/ishape.dart';

class PositionedShape extends StatelessWidget {
  final IShape shape;

  const PositionedShape({
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

    return Positioned(
      bottom: _getPosition(sizeHeight, 192.0),
      left: _getPosition(sizeWidth, 16.0),
      child: shape.render(),
    );
  }
}
