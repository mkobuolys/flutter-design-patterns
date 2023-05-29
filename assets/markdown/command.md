## Class diagram

![Command Class Diagram](resource:assets/images/command/command.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of the **Command** design pattern.

![Command Implementation Class Diagram](resource:assets/images/command/command_implementation.png)

`Command` defines a common interface for all the specific commands:

- `execute()` - executes the command;
- `getTitle()` - returns the command's title. Used in command history UI;
- `undo()` - undoes the command and returns the receiver to the previous state.

`ChangeColorCommand`, `ChangeHeightCommand` and `ChangeWidthCommand` are concrete implementations of the `Command` interface.

`Shape` is a receiver class which stores multiple properties defining the shape presented in UI: `color`, `height` and `width`.

`CommandHistory` is a simple class which stores a list of already executed commands (`commandList`) and provides methods to add a new command to the command history list (`add()`) and undo the last command from that list (`undo()`).

`CommandExample` initializes and contains `CommandHistory`, `Shape` objects. Also, this component contains multiple `PlatformButton` widgets which have a specific implementation of `Command` assigned to each of them. When the button is pressed, the command is executed and added to the command history list stored in `CommandHistory` object.

### Shape

A simple class to store information about the shape: its color, height and width. Also, this class contains a named constructor to create a shape object with pre-defined initial values.

```dart
class Shape {
  Shape.initial()
      : color = Colors.black,
        height = 150.0,
        width = 150.0;

  Color color;
  double height;
  double width;
}
```

### Command

An interface that defines methods to be implemented by the specific command classes.

```dart
abstract interface class Command {
  void execute();
  String getTitle();
  void undo();
}
```

### Commands

- `ChangeColorCommand` - a specific implementation of the command which changes the color of the `Shape` object.

```dart
class ChangeColorCommand implements Command {
  ChangeColorCommand(this.shape) : previousColor = shape.color;

  final Color previousColor;
  Shape shape;

  @override
  String getTitle() => 'Change color';

  @override
  void execute() => shape.color = Color.fromRGBO(
        random.integer(255),
        random.integer(255),
        random.integer(255),
        1.0,
      );

  @override
  void undo() => shape.color = previousColor;
}
```

- `ChangeHeightCommand` - a specific implementation of the command which changes the height of the `Shape` object.

```dart
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
```

- `ChangeWidthCommand` - a specific implementation of the command which changes the width of the `Shape` object.

```dart
class ChangeWidthCommand implements Command {
  ChangeWidthCommand(this.shape) : previousWidth = shape.width;

  final double previousWidth;
  Shape shape;

  @override
  String getTitle() => 'Change width';

  @override
  void execute() => shape.width = random.integer(150, min: 50).toDouble();

  @override
  void undo() => shape.width = previousWidth;
}
```

### CommandHistory

A simple class that stores a list of already executed commands. Also, this class provides `isEmpty` and `commandHistoryList` getter methods to return true if the command history list is empty and return a list of command names stored in the command history respectively. A new command could be added to the command history list via the `add()` method and the last command could be undone using the `undo()` method (if the command history list is not empty).

```dart
class CommandHistory {
  final _commandList = ListQueue<Command>();

  bool get isEmpty => _commandList.isEmpty;
  List<String> get commandHistoryList =>
      _commandList.map((c) => c.getTitle()).toList();

  void add(Command command) => _commandList.add(command);

  void undo() {
    if (_commandList.isEmpty) return;

    _commandList.removeLast().undo();
  }
}
```

### Example

`CommandExample` contains `CommandHistory` and `Shape` objects. Also, this widget contains several `PlatformButton` components, each of which uses a specific function executing a concrete command. After the command's execution, it is added to the command history list stored in the `CommandHistory` object. If the command history is not empty, the `Undo` button is enabled and the last command could be undone.

As you can see in this example, the client code (UI elements, command history, etc.) isn’t coupled to concrete command classes because it works with commands via the command interface. This approach allows introducing new commands into the application without breaking any existing code.

```dart
class CommandExample extends StatefulWidget {
  const CommandExample();

  @override
  _CommandExampleState createState() => _CommandExampleState();
}

class _CommandExampleState extends State<CommandExample> {
  final _commandHistory = CommandHistory();
  final _shape = Shape.initial();

  void _changeColor() {
    final command = ChangeColorCommand(_shape);
    _executeCommand(command);
  }

  void _changeHeight() {
    final command = ChangeHeightCommand(_shape);
    _executeCommand(command);
  }

  void _changeWidth() {
    final command = ChangeWidthCommand(_shape);
    _executeCommand(command);
  }

  void _executeCommand(Command command) => setState(() {
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
              shape: _shape,
            ),
            const SizedBox(height: LayoutConstants.spaceM),
            PlatformButton(
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _changeColor,
              text: 'Change color',
            ),
            PlatformButton(
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _changeHeight,
              text: 'Change height',
            ),
            PlatformButton(
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _changeWidth,
              text: 'Change width',
            ),
            const Divider(),
            PlatformButton(
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _commandHistory.isEmpty ? null : _undo,
              text: 'Undo',
            ),
            const SizedBox(height: LayoutConstants.spaceM),
            Row(
              children: <Widget>[
                CommandHistoryColumn(
                  commandList: _commandHistory.commandHistoryList,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```
