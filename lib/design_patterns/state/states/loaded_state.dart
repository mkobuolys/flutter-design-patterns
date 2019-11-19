import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/design_patterns/state/istate.dart';
import 'package:flutter_design_patterns/design_patterns/state/state_context.dart';
import 'package:flutter_design_patterns/design_patterns/state/states/loading_state.dart';

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
