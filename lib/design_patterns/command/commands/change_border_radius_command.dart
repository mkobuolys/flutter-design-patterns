import 'package:faker/faker.dart';

import 'package:flutter_design_patterns/design_patterns/command/command.dart';
import 'package:flutter_design_patterns/design_patterns/command/shape.dart';

class ChangeBorderRadiusCommand implements Command {
  Shape shape;
  double previousBorderRadius;

  ChangeBorderRadiusCommand(this.shape, this.previousBorderRadius);

  @override
  void execute() {
    shape.borderRadius = random.integer(100).toDouble();
  }

  @override
  String getTitle() {
    return 'Change border radius';
  }

  @override
  void undo() {
    shape.borderRadius = previousBorderRadius;
  }
}
