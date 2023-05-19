## Class diagram

![Memento Class Diagram](resource:assets/images/memento/memento.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of the **Memento** design pattern.

![Memento Implementation Class Diagram](resource:assets/images/memento/memento_implementation.png)

`ICommand` defines a common interface for the specific command:

- `execute()` - executes the command;
- `undo()` - undoes the command and returns the state to the previous snapshot of it.

`RandomisePropertiesCommand` is a concrete command which implements the abstract class `ICommand` and its methods.

`CommandHistory` is a simple class which stores a list of already executed commands (`commandList`) and provides methods to add a new command to the command history list (`add()`) and undo the last command from that list (`undo()`).

`IMemento` defines a common interface for the specific memento class:

- `getState()` - returns the snapshot of the internal originator's state.

`Memento` is a class that acts as a snapshot of the originator's internal state which is stored in the `state` property and returned via the `getState()` method.

`Shape` is a simple data class which is used as an internal originator's state. It stores multiple properties defining the shape presented in UI: `color`, `height` and `width`.

`Originator` - a simple class which contains its internal state and stores the snapshot of it to the `Memento` object using the `createMemento()` method. Also, the originator's state could be restored from the provided `Memento` object using the `restore()` method.

`MementoExample` initializes and contains `CommandHistory`, `Originator` objects. Also, this component contains a `PlatformButton` widget which has the command of `RandomisePropertiesCommand` assigned to it. When the button is pressed, the command is executed and added to the command history list stored in `CommandHistory` object.

### Shape

A simple class to store information about the shape: its color, height and width. Also, this class contains several constructors:

- `Shape()` - a basic constructor to create a shape object with provided values;
- `Shape.initial()` - a named constructor to create a shape object with pre-defined initial values;
- `Shape.copy()` - a named constructor to create a shape object as a copy of the provided `Shape` value.

```dart
class Shape {
  Shape.initial()
      : color = Colors.black,
        height = 150.0,
        width = 150.0;

  Shape.copy(Shape shape)
      : color = shape.color,
        height = shape.height,
        width = shape.width;

  Color color;
  double height;
  double width;
}
```

### ICommand

An interface that defines methods to be implemented by the specific command classes.

```dart
abstract interface class ICommand {
  void execute();
  void undo();
}
```

### RandomisePropertiesCommand

A specific implementation of the command which sets all the properties of the `Shape` object stored in the `Originator` to random values. Also, the class implements the `undo` operation.

```dart
class RandomisePropertiesCommand implements ICommand {
  RandomisePropertiesCommand(this.originator)
      : _backup = originator.createMemento();

  final Originator originator;
  final IMemento _backup;

  @override
  void execute() {
    final shape = originator.state;

    shape.color = Color.fromRGBO(
      random.integer(255),
      random.integer(255),
      random.integer(255),
      1.0,
    );
    shape.height = random.integer(150, min: 50).toDouble();
    shape.width = random.integer(150, min: 50).toDouble();
  }

  @override
  void undo() => originator.restore(_backup);
}
```

### CommandHistory

A simple class that stores a list of already executed commands. Also, this class provides `isEmpty` getter method to return true if the command history list is empty. A new command could be added to the command history list via the `add()` method and the last command could be undone using the `undo()` method (if the command history list is not empty).

```dart
class CommandHistory {
  final _commandList = ListQueue<ICommand>();

  bool get isEmpty => _commandList.isEmpty;

  void add(ICommand command) => _commandList.add(command);

  void undo() {
    if (_commandList.isEmpty) return;

    _commandList.removeLast().undo();
  }
}
```

### IMemento

An interface that defines the `getState()` method to be implemented by the specific Memento class.

```dart
abstract interface class IMemento {
  Shape getState();
}
```

### Memento

An implementation of the `IMemento` interface which stores the snapshot of `Originator's` internal state (`Shape` object). The state is accessible to the `Originator` via the `getState()` method.

```dart
class Memento implements IMemento {
  Memento(Shape shape) : _state = Shape.copy(shape);

  final Shape _state;

  @override
  Shape getState() => _state;
}
```

### Originator

A class which defines a `createMemento()` method to save the current internal state to a `Memento` object.

```dart
class Originator {
  Originator() : state = Shape.initial();

  Shape state;

  IMemento createMemento() => Memento(state);

  void restore(IMemento memento) => state = memento.getState();
}
```

### Example

`MementoExample` contains `CommandHistory` and `Originator` objects. Also, this widget contains a `PlatformButton` component which uses the `RandomisePropertiesCommand` to randomise property values of the shape. After the command's execution, it is added to the command history list stored in the `CommandHistory` object. If the command history is not empty, the `Undo` button is enabled and the last command could be undone.

As you can see in this example, the client code (UI elements, command history, etc.) isn’t coupled to any specific command class because it works with it via the `ICommand` interface.

In addition to what the Command design pattern provides to this example, the Memento design pattern adds an additional layer on the example's state. It is stored inside the Originator object, the command itself does not mutate the state directly but through the Originator. Also, the backup (state's snapshot) stored inside the Command is a Memento object and not the state (Shape object) itself - in case of the state's restore (undo is triggered on the command), the specific command calls the restore method on the Originator which restores its internal state to the value stored in the snapshot. Hence, it allows restoring multiple property values (a whole complex state object) in a single request, while the state itself is completely separated from the command's code or UI logic.

```dart
class MementoExample extends StatefulWidget {
  const MementoExample();

  @override
  _MementoExampleState createState() => _MementoExampleState();
}

class _MementoExampleState extends State<MementoExample> {
  final _commandHistory = CommandHistory();
  final _originator = Originator();

  void _randomiseProperties() {
    final command = RandomisePropertiesCommand(_originator);
    _executeCommand(command);
  }

  void _executeCommand(ICommand command) => setState(() {
        command.execute();
        _commandHistory.add(command);
      });

  void _undo() => setState(() => _commandHistory.undo());

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: LayoutConstants.paddingL,
        ),
        child: Column(
          children: <Widget>[
            ShapeContainer(
              shape: _originator.state,
            ),
            const SizedBox(height: LayoutConstants.spaceM),
            PlatformButton(
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _randomiseProperties,
              text: 'Randomise properties',
            ),
            const Divider(),
            PlatformButton(
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _commandHistory.isEmpty ? null : _undo,
              text: 'Undo',
            ),
            const SizedBox(height: LayoutConstants.spaceM),
          ],
        ),
      ),
    );
  }
}
```
