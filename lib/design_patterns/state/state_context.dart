import 'dart:async';

import 'package:flutter_design_patterns/design_patterns/state/istate.dart';
import 'package:flutter_design_patterns/design_patterns/state/states/loading_state.dart';
import 'package:flutter_design_patterns/design_patterns/state/states/no_results_state.dart';

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
