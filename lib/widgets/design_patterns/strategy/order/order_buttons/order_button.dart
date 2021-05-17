import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../constants.dart';

class OrderButton extends StatelessWidget {
  final IconData iconData;
  final String title;
  final VoidCallback onPressed;

  const OrderButton({
    required this.iconData,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          iconData,
          color: Colors.white,
        ),
        const SizedBox(width: spaceXS),
        Text(title),
      ],
    );

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: getRightButton(child),
    );
  }

  Widget getRightButton(Widget child) {
    final Widget materialButton = MaterialButton(
      color: Colors.black,
      textColor: Colors.white,
      disabledColor: Colors.grey,
      disabledTextColor: Colors.white,
      onPressed: onPressed,
      child: child,
    );

    final Widget cupertinoButton = CupertinoButton(
      color: Colors.black,
      onPressed: onPressed,
      child: child,
    );

    try {
      if (Platform.isAndroid) {
        return materialButton;
      } else {
        return cupertinoButton;
      }
    } catch (_) {
      return materialButton;
    }
  }
}
