import 'package:flutter/widgets.dart';

abstract class ISwitch {
  Widget render(bool value, ValueSetter<bool> onChanged);
}
