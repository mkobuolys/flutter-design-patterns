import 'package:faker/faker.dart';

import 'package:flutter_design_patterns/design_patterns/memento/command_design_pattern/command.dart';
import 'package:flutter_design_patterns/design_patterns/memento/command_design_pattern/shape.dart';

class ChangeWidthCommand implements Command {
  Shape shape;

  ChangeWidthCommand(this.shape) {}

  @override
  void execute() {
    shape.width = random.integer(150, min: 50).toDouble();
  }

  @override
  String getTitle() {
    return 'Change width';
  }

  @override
  void undo() {}
}
