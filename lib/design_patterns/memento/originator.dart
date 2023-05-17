import 'command_design_pattern/shape.dart';
import 'memento/imemento.dart';
import 'memento/memento.dart';

class Originator {
  Originator() : state = Shape.initial();

  Shape state;

  IMemento createMemento() => Memento(state);

  void restore(IMemento memento) => state = memento.getState();
}
