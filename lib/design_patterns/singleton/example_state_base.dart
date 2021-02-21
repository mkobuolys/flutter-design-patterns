import 'package:meta/meta.dart';

abstract class ExampleStateBase {
  @protected
  String initialText;
  @protected
  String stateText;
  String get currentText => stateText;

  // ignore: use_setters_to_change_properties
  void setStateText(String text) {
    stateText = text;
  }

  void reset() {
    stateText = initialText;
  }
}
