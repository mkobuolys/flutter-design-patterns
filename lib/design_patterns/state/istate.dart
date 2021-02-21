import 'package:flutter/widgets.dart';

import 'state_context.dart';

abstract class IState {
  Future nextState(StateContext context);
  Widget render();
}
