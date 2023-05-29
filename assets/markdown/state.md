## Class diagram

![State Class Diagram](resource:assets/images/state/state.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of the **State** design pattern.

![State Implementation Class Diagram](resource:assets/images/state/state_implementation.png)

`IState` defines a common interface for all the specific states:

- `nextState()` - changes the current state in `StateContext` object to the next state;
- `render()` - renders the UI of a specific state.

`NoResultsState`, `ErrorState`, `LoadingState` and `LoadedState` are concrete implementations of the `IState` interface. Each of the states defines its representational UI component via `render()` method, also uses a specific state (or states, if the next state is chosen from several possible options based on the context) of type `IState` in `nextState()`, which will be changed by calling the `nextState()` method. In addition to this, `LoadedState` contains a list of names, which is injected using the state's constructor, and `LoadingState` uses the `FakeApi` to retrieve a list of randomly generated names.

`StateContext` saves the current state of type `IState` in private `currentState` property, defines several methods:

- `setState()` - changes the current state;
- `nextState()` - triggers the `nextState()` method on the current state;
- `dispose()` - safely closes the `stateStream` stream.

The current state is exposed to the UI by using the `outState` stream.

`StateExample` widget contains the `StateContext` object to track and trigger state changes, also uses the `NoResultsState` as the initial state for the example.

### IState

An interface that defines methods to be implemented by all specific state classes.

```dart
abstract interface class IState {
  Future<void> nextState(StateContext context);
  Widget render();
}
```

### StateContext

A class that holds the current state in `currentState` property and exposes it to the UI via `outState` stream. The state context also defines a `nextState()` method which is used by the UI to trigger the state's change. The current state itself is changed/set via the `setState()` method by providing the next state of type `IState` as a parameter to it.

```dart
class StateContext {
  final _stateStream = StreamController<IState>();
  Sink<IState> get _inState => _stateStream.sink;
  Stream<IState> get outState => _stateStream.stream;

  late IState _currentState;

  StateContext() {
    _currentState = const NoResultsState();
    _addCurrentStateToStream();
  }

  void dispose() {
    _stateStream.close();
  }

  void setState(IState state) {
    _currentState = state;
    _addCurrentStateToStream();
  }

  void _addCurrentStateToStream() {
    _inState.add(_currentState);
  }

  Future<void> nextState() async {
    await _currentState.nextState(this);

    if (_currentState is LoadingState) {
      await _currentState.nextState(this);
    }
  }
}
```

### Specific implementations of the `IState` interface

- `ErrorState` - implements the specific state which is used when an unhandled error occurs in API and the error widget should be shown.

```dart
class ErrorState implements IState {
  const ErrorState();

  @override
  Future<void> nextState(StateContext context) async {
    context.setState(const LoadingState());
  }

  @override
  Widget render() {
    return const Text(
      'Oops! Something went wrong...',
      style: TextStyle(
        color: Colors.red,
        fontSize: 24.0,
      ),
      textAlign: TextAlign.center,
    );
  }
}
```

- `LoadedState` - implements the specific state which is used when resources are loaded from the API without an error and the result widget should be provided to the screen.

```dart
class LoadedState implements IState {
  const LoadedState(this.names);

  final List<String> names;

  @override
  Future<void> nextState(StateContext context) async {
    context.setState(const LoadingState());
  }

  @override
  Widget render() {
    return Column(
      children: names
          .map(
            (name) => Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                  child: Text(name[0]),
                ),
                title: Text(name),
              ),
            ),
          )
          .toList(),
    );
  }
}
```

- `NoResultsState` - implements the specific state which is used when a list of resources is loaded from the API without an error, but the list is empty. Also, this state is used initially in the `StateExample` widget.

```dart
class NoResultsState implements IState {
  const NoResultsState();

  @override
  Future<void> nextState(StateContext context) async {
    context.setState(const LoadingState());
  }

  @override
  Widget render() {
    return const Text(
      'No Results',
      style: TextStyle(fontSize: 24.0),
      textAlign: TextAlign.center,
    );
  }
}
```

- `LoadingState` - implements the specific state which is used on resources loading from the `FakeApi`. Also, based on the loaded result, the next state is set in `nextState()` method.

```dart
class LoadingState implements IState {
  const LoadingState({
    this.api = const FakeApi(),
  });

  final FakeApi api;

  @override
  Future<void> nextState(StateContext context) async {
    try {
      final resultList = await api.getNames();

      context.setState(
        resultList.isEmpty ? const NoResultsState() : LoadedState(resultList),
      );
    } on Exception {
      context.setState(const ErrorState());
    }
  }

  @override
  Widget render() {
    return const CircularProgressIndicator(
      backgroundColor: Colors.transparent,
      valueColor: AlwaysStoppedAnimation<Color>(
        Colors.black,
      ),
    );
  }
}
```

### FakeApi

A fake API is used to randomly generate a list of person names. The method `getNames()` could return a list of names or throw an Exception (error) at random. Similarly, the `getRandomNames()` method randomly returns a list of names or an empty list. This behaviour is implemented because of demonstration purposes to show all the possible different states in the UI.

```dart
class FakeApi {
  const FakeApi();

  Future<List<String>> getNames() => Future.delayed(
        const Duration(seconds: 2),
        () {
          if (random.boolean()) return _getRandomNames();

          throw Exception('Unexpected error');
        },
      );

  List<String> _getRandomNames() => List.generate(
        random.boolean() ? 3 : 0,
        (_) => faker.person.name(),
      );
}
```

### Example

`StateExample` widget contains the `StateContext`, subscribes to the current state's stream `outState` and provides an appropriate UI widget by executing the state's `render()` method. The current state could be changed by triggering the `changeState()` method (pressing the `Load names` button in UI). `StateExample` widget is only aware of the initial state class - `NoResultsState` but does not know any details about other possible states, since their handling is defined in `StateContext` class. This allows to separate business logic from the representational code, add new states of type `IState` to the application without applying any changes to the UI components.

```dart
class StateExample extends StatefulWidget {
  const StateExample();

  @override
  _StateExampleState createState() => _StateExampleState();
}

class _StateExampleState extends State<StateExample> {
  final _stateContext = StateContext();

  Future<void> _changeState() async {
    await _stateContext.nextState();
  }

  @override
  void dispose() {
    _stateContext.dispose();
    super.dispose();
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
            PlatformButton(
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _changeState,
              text: 'Load names',
            ),
            const SizedBox(height: LayoutConstants.spaceL),
            StreamBuilder<IState>(
              initialData: const NoResultsState(),
              stream: _stateContext.outState,
              builder: (context, snapshot) => snapshot.data!.render(),
            ),
          ],
        ),
      ),
    );
  }
}
```
