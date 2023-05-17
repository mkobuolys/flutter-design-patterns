import 'package:flutter/foundation.dart';

base class ExampleStateBase {
  @protected
  late String initialText;
  @protected
  late String stateText;
  String get currentText => stateText;

  // ignore: use_setters_to_change_properties
  void setStateText(String text) {
    stateText = text;
  }

  void reset() {
    stateText = initialText;
  }
}
