## Class diagram

![State Class Diagram](resource:assets/images/state/state.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of the **State** design pattern.

![State Implementation Class Diagram](resource:assets/images/state/state_implementation.png)

_IState_ defines a common interface for all the specific states:

- _nextState()_ - changes the current state in _StateContext_ object to the next state;
- _render()_ - renders the UI of a specific state.

_NoResultsState_, _ErrorState_, _LoadingState_ and _LoadedState_ are concrete implementations of the _IState_ interface. Each of the states defines its representational UI component via _render()_ method, also uses a specific state (or states, if the next state is chosen from several possible options based on the context) of type _IState_ in _nextState()_, which will be changed by calling the _nextState()_ method. In addition to this, _LoadedState_ contains a list of names, which is injected using the state's constructor, and _LoadingState_ uses the _FakeApi_ to retrieve a list of randomly generated names.

_StateContext_ saves the current state of type _IState_ in private _currentState_ property, defines several methods:

- _setState()_ - changes the current state;
- _nextState()_ - triggers the _nextState()_ method on the current state;
- _dispose()_ - safely closes the _stateStream_ stream.

The current state is exposed to the UI by using the _outState_ stream.

_StateExample_ widget contains the _StateContext_ object to track and trigger state changes, also uses the _NoResultsState_ as the initial state for the example.

### IState

An interface which defines methods to be implemented by all specific state classes. Dart language does not support the interface as a class type, so we define an interface by creating an abstract class and providing a method header (name, return type, parameters) without the default implementation.

```
abstract class IState {
  Future nextState(StateContext context);
  Widget render();
}
```

### StateContext

A class which holds the current state in _currentState_ property and exposes it to the UI via _outState_ stream. The state context also defines a _nextState()_ method which is used by the UI to trigger the state's change. The current state itself is changed/set via the _setState()_ method by providing the next state of type _IState_ as a parameter to it.

```
class StateContext {
  StreamController<IState> _stateStream = StreamController<IState>();
  Sink<IState> get _inState => _stateStream.sink;
  Stream<IState> get outState => _stateStream.stream;

  IState _currentState;

  StateContext() {
    _currentState = NoResultsState();
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

### Specific implementations of the _IState_ interface

- _ErrorState_ - implements the specific state which is used when an unhandled error occurs in API and the error widget should be shown.

```
class ErrorState implements IState {
  @override
  Future nextState(StateContext context) async {
    context.setState(LoadingState());
  }

  @override
  Widget render() {
    return Text(
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

- _LoadedState_ - implements the specific state which is used when resources are loaded from the API without an error and the result widget should be provided to the screen.

```
class LoadedState implements IState {
  final List<String> names;

  const LoadedState(this.names);

  @override
  Future nextState(StateContext context) async {
    context.setState(LoadingState());
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

- _NoResultsState_ - implements the specific state which is used when a list of resources is loaded from the API without an error, but the list is empty. Also, this state is used initially in the _StateExample_ widget.

```
class NoResultsState implements IState {
  @override
  Future nextState(StateContext context) async {
    context.setState(LoadingState());
  }

  @override
  Widget render() {
    return Text(
      'No Results',
      style: TextStyle(fontSize: 24.0),
      textAlign: TextAlign.center,
    );
  }
}
```

- _LoadingState_ - implements the specific state which is used on resources loading from the _FakeApi_. Also, based on the loaded result, the next state is set in _nextState()_ method.

```
class LoadingState implements IState {
  final FakeApi _api = FakeApi();

  @override
  Future nextState(StateContext context) async {
    try {
      var resultList = await _api.getNames();

      if (resultList.isEmpty) {
        context.setState(NoResultsState());
      } else {
        context.setState(LoadedState(resultList));
      }
    } on Exception {
      context.setState(ErrorState());
    }
  }

  @override
  Widget render() {
    return CircularProgressIndicator(
      backgroundColor: Colors.transparent,
      valueColor: AlwaysStoppedAnimation<Color>(
        Colors.black,
      ),
    );
  }
}
```

### FakeApi

A fake API which is used to randomly generate a list of person names. The method _getNames()_ could return a list of names or throw an Exception (error) at random. Similarly, the _getRandomNames()_ method randomly returns a list of names or an empty list. This behaviour is implemented because of demonstration purposes to show all the possible different states in the UI.

```
class FakeApi {
  Future<List<String>> getNames() async {
    return Future.delayed(
      const Duration(seconds: 2),
      () {
        if (random.boolean()) {
          return _getRandomNames();
        }

        throw Exception('Unexpected error');
      },
    );
  }

  List<String> _getRandomNames() {
    if (random.boolean()) {
      return [];
    }

    return [
      faker.person.name(),
      faker.person.name(),
      faker.person.name(),
    ];
  }
}
```

### Example

_StateExample_ widget contains the _StateContext_, subscribes to the current state's stream _outState_ and provides an appropriate UI widget by executing the state's _render()_ method. The current state could be changed by triggering the _changeState()_ method (pressing the _Load names_ button in UI). _StateExample_ widget is only aware of the initial state class - _NoResultsState_ but does not know any details about other possible states, since their handling is defined in _StateContext_ class. This allows to separate business logic from the representational code, add new states of type _IState_ to the application without applying any changes to the UI components.

```
class StateExample extends StatefulWidget {
  @override
  _StateExampleState createState() => _StateExampleState();
}

class _StateExampleState extends State<StateExample> {
  var _stateContext = StateContext();

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
      behavior: ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: paddingL),
        child: Column(
          children: <Widget>[
            PlatformButton(
              child: Text('Load names'),
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _changeState,
            ),
            const SizedBox(height: spaceL),
            StreamBuilder(
              initialData: NoResultsState(),
              stream: _stateContext.outState,
              builder: (_, AsyncSnapshot<IState> snapshot) =>
                  snapshot.data.render(),
            ),
          ],
        ),
      ),
    );
  }
}
```
