import 'package:flutter/material.dart';

class Shape {
  late Color color;
  late double height;
  late double width;

  Shape(this.color, this.height, this.width);

  Shape.initial() {
    color = Colors.black;
    height = 150.0;
    width = 150.0;
  }

  Shape.copy(Shape shape) : this(shape.color, shape.height, shape.width);
}
