import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../design_patterns/state/istate.dart';
import '../../../design_patterns/state/state_context.dart';
import '../../../design_patterns/state/states/no_results_state.dart';
import '../../platform_specific/platform_button.dart';

class StateExample extends StatefulWidget {
  @override
  _StateExampleState createState() => _StateExampleState();
}

class _StateExampleState extends State<StateExample> {
  final StateContext _stateContext = StateContext();

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
        padding: const EdgeInsets.symmetric(horizontal: paddingL),
        child: Column(
          children: <Widget>[
            PlatformButton(
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _changeState,
              text: 'Load names',
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
