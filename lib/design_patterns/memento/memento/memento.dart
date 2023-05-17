import '../command_design_pattern/shape.dart';
import 'imemento.dart';

class Memento implements IMemento {
  Memento(Shape shape) : _state = Shape.copy(shape);

  final Shape _state;

  @override
  Shape getState() => _state;
}
