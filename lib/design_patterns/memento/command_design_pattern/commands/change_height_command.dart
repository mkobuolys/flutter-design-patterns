import 'package:faker/faker.dart';

import 'package:flutter_design_patterns/design_patterns/memento/command_design_pattern/command.dart';
import 'package:flutter_design_patterns/design_patterns/memento/command_design_pattern/shape.dart';

class ChangeHeightCommand implements Command {
  Shape shape;

  ChangeHeightCommand(this.shape) {}

  @override
  void execute() {
    shape.height = random.integer(150, min: 50).toDouble();
  }

  @override
  String getTitle() {
    return 'Change height';
  }

  @override
  void undo() {}
}
