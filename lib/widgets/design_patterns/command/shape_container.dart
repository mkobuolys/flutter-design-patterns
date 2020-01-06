import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/design_patterns/command/shape.dart';

class ShapeContainer extends StatelessWidget {
  final Shape shape;

  const ShapeContainer({
    @required this.shape,
  }) : assert(shape != null);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160.0,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          height: shape.height,
          width: shape.width,
          decoration: BoxDecoration(
            color: shape.color,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Icon(
            Icons.star,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
