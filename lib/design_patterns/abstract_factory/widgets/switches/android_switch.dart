import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/design_patterns/abstract_factory/widgets/iswitch.dart';

class AndroidSwitch implements ISwitch {
  @override
  Widget render(bool value, ValueSetter<bool> onChanged) {
    return Switch(
      activeColor: Colors.black,
      value: value,
      onChanged: onChanged,
    );
  }
}
