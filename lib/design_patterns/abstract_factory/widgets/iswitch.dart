import 'package:flutter/widgets.dart';

abstract class ISwitch {
  Widget render({required bool value, required ValueSetter<bool> onChanged});
}
