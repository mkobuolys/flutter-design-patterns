import 'package:flutter/material.dart';

import '../../../themes.dart';
import '../../../widgets/platform_specific/platform_back_button.dart';

class DetailsAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;

  const DetailsAppBar({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: lightBackgroundColor,
      leading: const PlatformBackButton(color: Colors.black),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
