## Class diagram

![Memento Class Diagram](resource:assets/images/memento/memento.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of the **Memento** design pattern.

![Memento Implementation Class Diagram](resource:assets/images/memento/memento_implementation.png)

### Shape

A simple class to store information about the shape: its color, height and width. Also, this class contains several constructors:

- _Shape()_ - a basic constructor to create a shape object with provided values;
- _Shape.initial()_ - a named constructor to create a shape object with pre-defined initial values;
- _Shape.copy()_ - a named constructor to create a shape object as a copy of the provided _Shape_ value.

```
class Shape {
  Color color;
  double height;
  double width;

  Shape(this.color, this.height, this.width);

  Shape.initial() {
    color = Colors.black;
    height = 150.0;
    width = 150.0;
  }

  Shape.copy(Shape shape) : this(shape.color, shape.height, shape.width);
}
```

### ICommand

An interface which defines methods to be implemented by the specific command classes. Dart language does not support the interface as a class type, so we define an interface by creating an abstract class and providing a method header (name, return type, parameters) without the default implementation.

```
abstract class ICommand {
  void execute();
  void undo();
}
```

### RandomisePropertiesCommand

A specific implementation of the command which sets all the properties of the _Shape_ object stored in the _Originator_ to random values. Also, implements the _undo_ operation.

```
class RandomisePropertiesCommand implements ICommand {
  Originator originator;
  IMemento _backup;

  RandomisePropertiesCommand(this.originator) {
    _backup = originator.createMemento();
  }

  @override
  void execute() {
    var shape = originator.state;
    shape.color = Color.fromRGBO(
        random.integer(255), random.integer(255), random.integer(255), 1.0);
    shape.height = random.integer(150, min: 50).toDouble();
    shape.width = random.integer(150, min: 50).toDouble();
  }

  @override
  void undo() {
    if (_backup != null) {
      originator.restore(_backup);
    }
  }
}
```

### CommandHistory

A simple class which stores a list of already executed commands. Also, this class provides _isEmpty_ getter method to return true if the command history list is empty. A new command could be added to the command history list via the _add()_ method and the last command could be undone using the _undo()_ method (if the command history list is not empty).

```
class CommandHistory {
  final ListQueue<ICommand> _commandList = ListQueue<ICommand>();

  bool get isEmpty => _commandList.isEmpty;

  void add(ICommand command) {
    _commandList.add(command);
  }

  void undo() {
    if (_commandList.isNotEmpty) {
      var command = _commandList.removeLast();
      command.undo();
    }
  }
}
```

### IMemento

```
abstract class IMemento {
  Shape getState();
}
```

### Memento

```
class Memento extends IMemento {
  Shape _state;

  Memento(Shape shape) {
    _state = Shape.copy(shape);
  }

  Shape getState() {
    return _state;
  }
}
```

### Originator

```
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
```

### Example

```
class MementoExample extends StatefulWidget {
  @override
  _MementoExampleState createState() => _MementoExampleState();
}

class _MementoExampleState extends State<MementoExample> {
  final CommandHistory _commandHistory = CommandHistory();
  final Originator _originator = Originator();

  void _randomiseProperties() {
    var command = RandomisePropertiesCommand(_originator);
    _executeCommand(command);
  }

  void _executeCommand(ICommand command) {
    setState(() {
      command.execute();
      _commandHistory.add(command);
    });
  }

  void _undo() {
    setState(() {
      _commandHistory.undo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: paddingL),
        child: Column(
          children: <Widget>[
            ShapeContainer(
              shape: _originator.state,
            ),
            const SizedBox(height: spaceM),
            PlatformButton(
              child: Text('Randomise properties'),
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _randomiseProperties,
            ),
            Divider(),
            PlatformButton(
              child: Text('Undo'),
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _commandHistory.isEmpty ? null : _undo,
            ),
            const SizedBox(height: spaceM),
          ],
        ),
      ),
    );
  }
}
```
