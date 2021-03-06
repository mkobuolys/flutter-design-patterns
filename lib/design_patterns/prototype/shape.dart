import 'package:flutter/material.dart';

abstract class Shape {
  late Color color;

  Shape(this.color);

  Shape.clone(Shape source) {
    color = source.color;
  }

  Shape clone();
  void randomiseProperties();
  Widget render();
}
