import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/design_patterns/flyweight/ishape.dart';

class Circle implements IShape {
  final Color color;
  final double diameter;

  Circle({
    @required this.color,
    @required this.diameter,
  })  : assert(color != null),
        assert(diameter != null);

  @override
  Widget render() {
    return Container(
      height: diameter,
      width: diameter,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
