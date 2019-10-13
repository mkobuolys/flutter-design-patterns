import 'package:meta/meta.dart';

abstract class ExampleStateBase {
  @protected
  String initialText;
  @protected
  String stateText;
  String get currentText => stateText;

  void setStateText(String text) {
    stateText = text;
  }

  void reset() {
    stateText = initialText;
  }
}
