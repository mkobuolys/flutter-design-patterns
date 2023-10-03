## Class diagram

![Singleton Class Diagram](resource:assets/images/singleton/singleton.png)

## Implementation

### Class diagram

The diagram shows only the Singleton implementation by definition (`ExampleStateByDefinition` class). This class diagram is selected because it represents a general Singleton's class diagram the most accurately.

![Singleton Implementation Class Diagram](resource:assets/images/singleton/singleton_implementation.png)

### ExampleStateBase

A base class for the abstraction of example's state which contains an initial text value, a single text property and methods to operate it.

```dart
base class ExampleStateBase {
  @protected
  late String initialText;
  @protected
  late String stateText;
  String get currentText => stateText;

  void setStateText(String text) {
    stateText = text;
  }

  void reset() {
    stateText = initialText;
  }
}
```

### Example's state implementations

Example's state is implemented in 3 different ways:

- ExampleStateByDefinition - example's state is a Singleton which is implemented by definition.

```dart
final class ExampleStateByDefinition extends ExampleStateBase {
  static ExampleStateByDefinition? _instance;

  ExampleStateByDefinition._internal() {
    initialText = "A new 'ExampleStateByDefinition' instance has been created.";
    stateText = initialText;
  }

  static ExampleStateByDefinition getState() {
    return _instance ??= ExampleStateByDefinition._internal();
  }
}
```

- ExampleState - example's state is a Singleton which is implemented using the Dart language capabilities.

```dart
final class ExampleState extends ExampleStateBase {
  static final ExampleState _instance = ExampleState._internal();

  factory ExampleState() {
    return _instance;
  }

  ExampleState._internal() {
    initialText = "A new 'ExampleState' instance has been created.";
    stateText = initialText;
  }
}
```

- ExampleStateWithoutSingleton - example's state is implemented without using a Singleton design pattern.

```dart
final class ExampleStateWithoutSingleton extends ExampleStateBase {
  ExampleStateWithoutSingleton() {
    initialText =
        "A new 'ExampleStateWithoutSingleton' instance has been created.";
    stateText = initialText;
  }
}
```

### Example

Example uses all three different implementations of the state. Singleton implementations (`ExampleStateByDefinition` and `ExampleState`) create a new state object only on the first creation of the `SingletonExample` widget, but the `ExampleStateWithoutSingleton` instance is created on each creation of the `SingletonExample` widget.

```dart
class SingletonExample extends StatefulWidget {
  const SingletonExample();

  @override
  _SingletonExampleState createState() => _SingletonExampleState();
}

class _SingletonExampleState extends State<SingletonExample> {
  final List<ExampleStateBase> stateList = [
    ExampleState(),
    ExampleStateByDefinition.getState(),
    ExampleStateWithoutSingleton(),
  ];

  void _setTextValues([String text = 'Singleton']) {
    for (final state in stateList) {
      state.setStateText(text);
    }
    setState(() {});
  }

  void _reset() {
    for (final state in stateList) {
      state.reset();
    }
    setState(() {});
  }

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
            for (final state in stateList)
              Padding(
                padding: const EdgeInsets.only(
                  bottom: LayoutConstants.paddingL,
                ),
                child: SingletonExampleCard(text: state.currentText),
              ),
            const SizedBox(height: LayoutConstants.spaceL),
            PlatformButton(
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _setTextValues,
              text: "Change states' text to 'Singleton'",
            ),
            PlatformButton(
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _reset,
              text: 'Reset',
            ),
            const SizedBox(height: LayoutConstants.spaceXL),
            const Text(
              "Note: change states' text and navigate the application (e.g. go to main menu, then go back to this example) to see how the Singleton state behaves!",
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
```
