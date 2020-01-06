import 'package:faker/faker.dart';

import 'package:flutter_design_patterns/design_patterns/command/command.dart';
import 'package:flutter_design_patterns/design_patterns/command/shape.dart';

class ChangeWidthCommand implements Command {
  Shape shape;
  double previousWidth;

  ChangeWidthCommand(this.shape) {
    previousWidth = shape.width;
  }

  @override
  void execute() {
    shape.width = random.integer(150, min: 50).toDouble();
  }

  @override
  String getTitle() {
    return 'Change width';
  }

  @override
  void undo() {
    shape.width = previousWidth;
  }
}
