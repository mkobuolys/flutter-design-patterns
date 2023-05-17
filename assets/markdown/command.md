## Class diagram

![Command Class Diagram](resource:assets/images/command/command.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of the **Command** design pattern.

![Command Implementation Class Diagram](resource:assets/images/command/command_implementation.png)

_Command_ defines a common interface for all the specific commands:

- _execute()_ - executes the command;
- _getTitle()_ - returns the command's title. Used in command history UI;
- _undo()_ - undoes the command and returns the receiver to the previous state.

_ChangeColorCommand_, _ChangeHeightCommand_ and _ChangeWidthCommand_ are concrete implementations of the _Command_ interface.

_Shape_ is a receiver class which stores multiple properties defining the shape presented in UI: _color_, _height_ and _width_.

_CommandHistory_ is a simple class which stores a list of already executed commands (_commandList_) and provides methods to add a new command to the command history list (_add()_) and undo the last command from that list (_undo()_).

_CommandExample_ initializes and contains _CommandHistory_, _Shape_ objects. Also, this component contains multiple _PlatformButton_ widgets which have a specific implementation of _Command_ assigned to each of them. When the button is pressed, the command is executed and added to the command history list stored in _CommandHistory_ object.

### Shape

A simple class to store information about the shape: its color, height and width. Also, this class contains a named constructor to create a shape object with pre-defined initial values.

```
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

```
abstract interface class Command {
  void execute();
  String getTitle();
  void undo();
}
```

### Commands

- _ChangeColorCommand_ - a specific implementation of the command which changes the color of the _Shape_ object.

```
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

- _ChangeHeightCommand_ - a specific implementation of the command which changes the height of the _Shape_ object.

```
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

- _ChangeWidthCommand_ - a specific implementation of the command which changes the width of the _Shape_ object.

```
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

A simple class that stores a list of already executed commands. Also, this class provides _isEmpty_ and _commandHistoryList_ getter methods to return true if the command history list is empty and return a list of command names stored in the command history respectively. A new command could be added to the command history list via the _add()_ method and the last command could be undone using the _undo()_ method (if the command history list is not empty).

```
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

_CommandExample_ contains _CommandHistory_ and _Shape_ objects. Also, this widget contains several _PlatformButton_ components, each of which uses a specific function executing a concrete command. After the command's execution, it is added to the command history list stored in the _CommandHistory_ object. If the command history is not empty, the _Undo_ button is enabled and the last command could be undone.

As you can see in this example, the client code (UI elements, command history, etc.) isn’t coupled to concrete command classes because it works with commands via the command interface. This approach allows introducing new commands into the application without breaking any existing code.

```
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
