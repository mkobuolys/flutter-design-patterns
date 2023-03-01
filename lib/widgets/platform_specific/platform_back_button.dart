import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../navigation/router.dart';

class PlatformBackButton extends StatelessWidget {
  const PlatformBackButton({
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    final icon =
        Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios_new;

    return IconButton(
      icon: Icon(icon),
      color: color,
      splashRadius: 20.0,
      onPressed: () {
        context.canPop() ? context.pop() : const MainMenuRoute().go(context);
      },
    );
  }
}
