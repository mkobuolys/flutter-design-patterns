import 'package:flutter/widgets.dart';

import 'state_context.dart';

abstract interface class IState {
  Future<void> nextState(StateContext context);
  Widget render();
}
