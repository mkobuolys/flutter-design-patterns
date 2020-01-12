import 'package:flutter_design_patterns/design_patterns/memento/command_design_pattern/shape.dart';

class Memento {
  Shape _state;

  Memento(Shape shape) {
    _state = shape;
  }

  Shape getState() {
    return _state;
  }
}
