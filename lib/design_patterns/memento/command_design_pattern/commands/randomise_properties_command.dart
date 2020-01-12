import 'package:faker/faker.dart';

import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/design_patterns/memento/command_design_pattern/icommand.dart';
import 'package:flutter_design_patterns/design_patterns/memento/memento/imemento.dart';
import 'package:flutter_design_patterns/design_patterns/memento/originator.dart';

class RandomisePropertiesCommand implements ICommand {
  Originator originator;
  IMemento _backup;

  RandomisePropertiesCommand(this.originator) {
    _backup = originator.createMemento();
  }

  @override
  void execute() {
    var shape = originator.state;
    shape.color = Color.fromRGBO(
        random.integer(255), random.integer(255), random.integer(255), 1.0);
    shape.height = random.integer(150, min: 50).toDouble();
    shape.width = random.integer(150, min: 50).toDouble();
  }

  @override
  void undo() {
    if (_backup != null) {
      originator.restore(_backup);
    }
  }
}
