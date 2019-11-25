import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ModeSwitcher extends StatelessWidget {
  final String title;
  final bool activated;
  final ValueSetter<bool> onChanged;

  const ModeSwitcher({
    @required this.title,
    @required this.activated,
    @required this.onChanged,
  })  : assert(title != null),
        assert(activated != null);
  @override
  Widget build(BuildContext context) {
    return SwitchListTile.adaptive(
      title: Text(title),
      activeColor: Colors.black,
      value: activated,
      onChanged: onChanged,
    );
  }
}
