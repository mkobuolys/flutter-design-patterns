import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/constants.dart';
import 'package:flutter_design_patterns/design_patterns/singleton/example_state.dart';
import 'package:flutter_design_patterns/design_patterns/singleton/example_state_by_definition.dart';
import 'package:flutter_design_patterns/design_patterns/singleton/example_state_without_singleton.dart';
import 'package:flutter_design_patterns/design_patterns/singleton/example_state_base.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/singleton/singleton_example_card.dart';
import 'package:flutter_design_patterns/widgets/platform_specific/platform_button.dart';

class SingletonExample extends StatefulWidget {
  @override
  _SingletonExampleState createState() => _SingletonExampleState();
}

class _SingletonExampleState extends State<SingletonExample> {
  final List<ExampleStateBase> stateList = [
    ExampleState(),
    ExampleStateByDefinition.getState(),
    ExampleStateWithoutSingleton()
  ];

  void _setTextValues([String text = 'Singleton']) {
    for (var state in stateList) {
      state.setStateText(text);
    }
    setState(() {});
  }

  void _reset() {
    for (var state in stateList) {
      state.reset();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: paddingL),
        child: Column(
          children: <Widget>[
            for (var state in stateList)
              Padding(
                padding: const EdgeInsets.only(bottom: paddingL),
                child: SingletonExampleCard(
                  text: state.currentText,
                ),
              ),
            const SizedBox(height: spaceL),
            PlatformButton(
              child: Text("Change states\' text to 'Singleton'"),
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _setTextValues,
            ),
            PlatformButton(
              child: Text("Reset"),
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _reset,
            ),
            const SizedBox(height: spaceXL),
            Text(
              'Note: change states\' text and navigate the application (e.g. go to the tab "description" or main menu, then go back to this example) to see how the Singleton state behaves!',
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
