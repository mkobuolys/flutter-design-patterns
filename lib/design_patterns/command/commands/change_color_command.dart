import 'package:faker/faker.dart';

import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/design_patterns/command/command.dart';
import 'package:flutter_design_patterns/design_patterns/command/shape.dart';

class ChangeColorCommand implements Command {
  Shape shape;
  Color previousColor;

  ChangeColorCommand(this.shape, this.previousColor);

  @override
  void execute() {
    shape.color = Color.fromRGBO(
        random.integer(255), random.integer(255), random.integer(255), 1.0);
  }

  @override
  String getTitle() {
    return 'Change color';
  }

  @override
  void undo() {
    shape.color = previousColor;
  }
}
