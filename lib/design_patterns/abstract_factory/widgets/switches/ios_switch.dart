import 'package:flutter/cupertino.dart';

import '../iswitch.dart';

class IosSwitch implements ISwitch {
  @override
  Widget render({bool value, ValueSetter<bool> onChanged}) {
    return CupertinoSwitch(
      value: value,
      onChanged: onChanged,
    );
  }
}
