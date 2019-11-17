import 'package:flutter/widgets.dart';

import 'package:flutter_design_patterns/design_patterns/state/state_context.dart';

abstract class IState {
  Future nextState(StateContext context);
  Widget render();
}
