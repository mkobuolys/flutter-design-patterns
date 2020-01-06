import 'package:faker/faker.dart';

import 'package:flutter_design_patterns/design_patterns/command/command.dart';
import 'package:flutter_design_patterns/design_patterns/command/shape.dart';

class ChangeHeightCommand implements Command {
  Shape shape;
  double previousHeight;

  ChangeHeightCommand(this.shape) {
    previousHeight = shape.height;
  }

  @override
  void execute() {
    shape.height = random.integer(150, min: 50).toDouble();
  }

  @override
  String getTitle() {
    return 'Change height';
  }

  @override
  void undo() {
    shape.height = previousHeight;
  }
}
