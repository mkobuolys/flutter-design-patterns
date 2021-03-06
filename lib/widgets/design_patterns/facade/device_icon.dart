import 'package:flutter/material.dart';

class DeviceIcon extends StatelessWidget {
  final IconData iconData;
  final bool activated;

  const DeviceIcon({
    required this.iconData,
    required this.activated,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      iconData,
      color: activated ? Colors.green : Colors.red,
      size: 42.0,
    );
  }
}
