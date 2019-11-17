import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/design_patterns/state/fake_api.dart';
import 'package:flutter_design_patterns/design_patterns/state/istate.dart';
import 'package:flutter_design_patterns/design_patterns/state/state_context.dart';
import 'package:flutter_design_patterns/design_patterns/state/states/error_state.dart';
import 'package:flutter_design_patterns/design_patterns/state/states/loaded_state.dart';
import 'package:flutter_design_patterns/design_patterns/state/states/no_results_state.dart';

class LoadingState implements IState {
  final FakeApi _api = FakeApi();

  @override
  Future nextState(StateContext context) async {
    try {
      var resultList = await _api.getRandomNames();

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
