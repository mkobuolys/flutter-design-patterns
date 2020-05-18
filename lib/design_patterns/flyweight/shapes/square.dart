import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/design_patterns/flyweight/ishape.dart';

class Square implements IShape {
  final Color color;
  final double width;

  Square({
    @required this.color,
    @required this.width,
  })  : assert(color != null),
        assert(width != null);

  double get height => width;

  @override
  Widget render() {
    return Container(
      height: height,
      width: width,
      color: color,
    );
  }
}
