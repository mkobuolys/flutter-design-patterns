import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/design_patterns/state/istate.dart';
import 'package:flutter_design_patterns/design_patterns/state/state_context.dart';
import 'package:flutter_design_patterns/design_patterns/state/states/loading_state.dart';

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
