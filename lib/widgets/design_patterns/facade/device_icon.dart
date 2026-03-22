import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DeviceIcon extends StatelessWidget {
  final Object? iconData;
  final bool activated;

  const DeviceIcon({
    required this.iconData,
    required this.activated,
  });

  @override
  Widget build(BuildContext context) {
    if (iconData is FaIconData) {
      return FaIcon(
        iconData as FaIconData, // ignore: cast_nullable_to_non_nullable
        color: activated ? Colors.green : Colors.red,
        size: 42.0,
      );
    }
    return Icon(
      iconData as IconData?,
      color: activated ? Colors.green : Colors.red,
      size: 42.0,
    );
  }
}
