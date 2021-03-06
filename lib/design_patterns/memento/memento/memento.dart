import '../command_design_pattern/shape.dart';
import 'imemento.dart';

class Memento extends IMemento {
  late final Shape _state;

  Memento(Shape shape) {
    _state = Shape.copy(shape);
  }

  @override
  Shape getState() {
    return _state;
  }
}
