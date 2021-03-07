import 'command_design_pattern/shape.dart';
import 'memento/imemento.dart';
import 'memento/memento.dart';

class Originator {
  late Shape state;

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
