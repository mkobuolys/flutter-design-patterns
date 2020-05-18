import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/design_patterns/flyweight/ishape.dart';
import 'package:flutter_design_patterns/design_patterns/flyweight/shape_type.dart';
import 'package:flutter_design_patterns/design_patterns/flyweight/shapes/index.dart';

class ShapeFactory {
  IShape createShape(ShapeType shapeType) {
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
        throw new Exception("Shape type '$shapeType' is not supported.");
    }
  }
}
