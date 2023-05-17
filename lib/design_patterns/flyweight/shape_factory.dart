import 'package:flutter/material.dart';

import 'ipositioned_shape.dart';
import 'shape_type.dart';
import 'shapes/index.dart';

class ShapeFactory {
  const ShapeFactory();

  IPositionedShape createShape(ShapeType shapeType) => switch (shapeType) {
        ShapeType.circle => Circle(
            color: Colors.red.withOpacity(0.2),
            diameter: 10.0,
          ),
        ShapeType.square => Square(
            color: Colors.blue.withOpacity(0.2),
            width: 10.0,
          ),
      };
}
