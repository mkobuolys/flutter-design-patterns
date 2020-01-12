import 'package:flutter_design_patterns/design_patterns/memento/command_design_pattern/shape.dart';
import 'package:flutter_design_patterns/design_patterns/memento/memento/imemento.dart';
import 'package:flutter_design_patterns/design_patterns/memento/memento/memento.dart';

class Originator {
  Shape state;

  Originator() {
    state = Shape.initial();
  }

  IMemento createMemento() {
    return Memento(state);
  }

  void restore(IMemento memento) {
    state = memento.getState();
  }
}
