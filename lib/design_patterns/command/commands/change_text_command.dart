import 'package:faker/faker.dart';

import 'package:flutter_design_patterns/design_patterns/command/command.dart';
import 'package:flutter_design_patterns/design_patterns/command/shape.dart';

class ChangeTextCommand implements Command {
  Shape shape;
  String previousText;

  ChangeTextCommand(this.shape, this.previousText);

  @override
  void execute() {
    shape.text = faker.lorem.word();
  }

  @override
  String getTitle() {
    return 'Change text';
  }

  @override
  void undo() {
    shape.text = previousText;
  }
}
