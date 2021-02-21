import 'package:flutter/material.dart';

import 'ipositioned_shape.dart';
import 'shape_type.dart';
import 'shapes/index.dart';

class ShapeFactory {
  IPositionedShape createShape(ShapeType shapeType) {
    switch (shapeType) {
      case ShapeType.Circle:
        return Circle(
          color: Colors.red.withOpacity(0.2),
          diameter: 10.0,
        );
      case ShapeType.Square:
        return Square(
          color: Colors.blue.withOpacity(0.2),
          width: 10.0,
        );
      default:
        throw Exception("Shape type '$shapeType' is not supported.");
    }
  }
}
