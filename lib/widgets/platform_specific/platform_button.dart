import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformButton extends StatelessWidget {
  final String text;
  final Color materialColor;
  final Color materialTextColor;
  final VoidCallback onPressed;

  const PlatformButton({
    @required this.text,
    @required this.materialColor,
    @required this.materialTextColor,
    this.onPressed,
  })  : assert(text != null),
        assert(materialColor != null),
        assert(materialTextColor != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Platform.isAndroid
          ? MaterialButton(
              color: materialColor,
              textColor: materialTextColor,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.white,
              onPressed: onPressed,
              child: Text(text, textAlign: TextAlign.center),
            )
          : CupertinoButton(
              color: Colors.black,
              onPressed: onPressed,
              child: Text(text, textAlign: TextAlign.center),
            ),
    );
  }
}
