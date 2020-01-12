import 'package:flutter_design_patterns/design_patterns/memento/command_design_pattern/shape.dart';
import 'package:flutter_design_patterns/design_patterns/memento/memento.dart';

class Originator {
  Shape _state;

  Memento createMemento() {
    return Memento(_state);
  }

  void restore(Memento memento) {
    _state = memento.getState();
  }

  Shape getState() {
    return _state;
  }

  void setState(Shape state) {
    _state = state;
  }
}
