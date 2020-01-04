import 'package:faker/faker.dart';

import 'package:flutter/material.dart';

class Shape {
  double borderRadius;
  Color color;
  String text;

  Shape.initial() {
    borderRadius = random.integer(100).toDouble();
    color = Color.fromRGBO(
        random.integer(255), random.integer(255), random.integer(255), 1.0);
    text = faker.lorem.word();
  }
}
