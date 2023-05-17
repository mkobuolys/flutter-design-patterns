import 'package:flutter/widgets.dart';

abstract interface class ISwitch {
  Widget render({required bool value, required ValueSetter<bool> onChanged});
}
