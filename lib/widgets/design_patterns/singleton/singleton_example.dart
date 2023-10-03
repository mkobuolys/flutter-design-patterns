import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../design_patterns/singleton/singleton.dart';
import '../../platform_specific/platform_button.dart';
import 'singleton_example_card.dart';

class SingletonExample extends StatefulWidget {
  const SingletonExample();

  @override
  _SingletonExampleState createState() => _SingletonExampleState();
}

class _SingletonExampleState extends State<SingletonExample> {
  final List<ExampleStateBase> stateList = [
    ExampleState(),
    ExampleStateByDefinition.getState(),
    ExampleStateWithoutSingleton(),
  ];

  void _setTextValues([String text = 'Singleton']) {
    for (final state in stateList) {
      state.setStateText(text);
    }
    setState(() {});
  }

  void _reset() {
    for (final state in stateList) {
      state.reset();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: LayoutConstants.paddingL,
        ),
        child: Column(
          children: <Widget>[
            for (final state in stateList)
              Padding(
                padding: const EdgeInsets.only(
                  bottom: LayoutConstants.paddingL,
                ),
                child: SingletonExampleCard(text: state.currentText),
              ),
            const SizedBox(height: LayoutConstants.spaceL),
            PlatformButton(
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _setTextValues,
              text: "Change states' text to 'Singleton'",
            ),
            PlatformButton(
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _reset,
              text: 'Reset',
            ),
            const SizedBox(height: LayoutConstants.spaceXL),
            const Text(
              "Note: change states' text and navigate the application (e.g. go to main menu, then go back to this example) to see how the Singleton state behaves!",
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
