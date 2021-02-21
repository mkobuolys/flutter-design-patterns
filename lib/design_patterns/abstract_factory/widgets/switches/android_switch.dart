import 'package:flutter/material.dart';

import '../iswitch.dart';

class AndroidSwitch implements ISwitch {
  @override
  Widget render({bool value, ValueSetter<bool> onChanged}) {
    return Switch(
      activeColor: Colors.black,
      value: value,
      onChanged: onChanged,
    );
  }
}
