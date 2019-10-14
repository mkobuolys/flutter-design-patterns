import 'package:flutter_design_patterns/design_patterns/singleton/example_state_base.dart';

class ExampleStateByDefinition extends ExampleStateBase {
  static ExampleStateByDefinition _instance;

  ExampleStateByDefinition._internal() {
    initialText = "A new 'ExampleStateByDefinition' instance has been created.";
    stateText = initialText;
    print(stateText);
  }

  static ExampleStateByDefinition getState() {
    if (_instance == null) {
      _instance = ExampleStateByDefinition._internal();
    }

    return _instance;
  }
}
