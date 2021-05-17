import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PlatformBackButton extends StatelessWidget {
  final Color color;

  const PlatformBackButton({
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        kIsWeb || Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
      ),
      color: color,
      onPressed: () => Navigator.pop(context),
    );
  }
}
