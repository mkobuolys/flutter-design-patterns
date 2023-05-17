import 'package:faker/faker.dart';

import '../command.dart';
import '../shape.dart';

class ChangeHeightCommand implements Command {
  ChangeHeightCommand(this.shape) : previousHeight = shape.height;

  final double previousHeight;
  Shape shape;

  @override
  String getTitle() => 'Change height';

  @override
  void execute() => shape.height = random.integer(150, min: 50).toDouble();

  @override
  void undo() => shape.height = previousHeight;
}
