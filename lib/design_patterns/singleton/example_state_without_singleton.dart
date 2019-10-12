import 'package:flutter_design_patterns/design_patterns/singleton/example_state_base.dart';

class ExampleStateWithoutSingleton extends ExampleStateBase {
  ExampleStateWithoutSingleton() {
    initialText =
        "A new 'ExampleStateWithoutSingleton' instance has been created.";
    stateText = initialText;
    print(stateText);
  }
}
