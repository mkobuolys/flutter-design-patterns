import 'package:flutter/material.dart';

import '../ipositioned_shape.dart';

class Circle implements IPositionedShape {
  final Color color;
  final double diameter;

  Circle({
    @required this.color,
    @required this.diameter,
  })  : assert(color != null),
        assert(diameter != null);

  @override
  Widget render(double x, double y) {
    return Positioned(
      left: x,
      bottom: y,
      child: Container(
        height: diameter,
        width: diameter,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
