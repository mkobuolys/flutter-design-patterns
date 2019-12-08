import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class PlatformButton extends StatelessWidget {
  final Widget child;
  final Color materialColor;
  final Color materialTextColor;
  final VoidCallback onPressed;

  const PlatformButton({
    @required this.child,
    @required this.materialColor,
    @required this.materialTextColor,
    this.onPressed,
  })  : assert(child != null),
        assert(materialColor != null),
        assert(materialTextColor != null);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? MaterialButton(
            child: child,
            color: materialColor,
            textColor: materialTextColor,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.white,
            onPressed: onPressed,
          )
        : CupertinoButton.filled(
            child: child,
            onPressed: onPressed,
          );
  }
}
