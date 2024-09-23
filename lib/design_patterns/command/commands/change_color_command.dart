import 'package:faker/faker.dart' as faker;
import 'package:flutter/material.dart';

import '../command.dart';
import '../shape.dart';

class ChangeColorCommand implements Command {
  ChangeColorCommand(this.shape) : previousColor = shape.color;

  final Color previousColor;
  Shape shape;

  @override
  String getTitle() => 'Change color';

  @override
  void execute() => shape.color = Color.fromRGBO(
        faker.random.integer(255),
        faker.random.integer(255),
        faker.random.integer(255),
        1.0,
      );

  @override
  void undo() => shape.color = previousColor;
}
