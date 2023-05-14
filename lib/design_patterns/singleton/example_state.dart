import 'example_state_base.dart';

final class ExampleState extends ExampleStateBase {
  static final ExampleState _instance = ExampleState._internal();

  factory ExampleState() {
    return _instance;
  }

  ExampleState._internal() {
    initialText = "A new 'ExampleState' instance has been created.";
    stateText = initialText;
  }
}
