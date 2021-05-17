import 'dart:io';

import 'package:flutter/material.dart';

class PlatformBackButton extends StatelessWidget {
  final Color color;

  const PlatformBackButton({
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(getValidIcon),
      color: color,
      onPressed: () => Navigator.pop(context),
    );
  }

  IconData get getValidIcon {
    IconData icon;
    try {
      Platform.isAndroid
          ? icon = Icons.arrow_back
          : icon = Icons.arrow_back_ios;
    } catch (_) {
      icon = Icons.arrow_back;
    }

    return icon;
  }
}
