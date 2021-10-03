import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../themes.dart';
import '../../../../widgets/platform_specific/platform_back_button.dart';
import '../../../data/models/design_pattern.dart';
import '../../../helpers/helpers.dart';

class DetailsAppBar extends StatelessWidget with PreferredSizeWidget {
  final DesignPattern designPattern;

  const DetailsAppBar({
    required this.designPattern,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        designPattern.title,
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: lightBackgroundColor,
      leading: const PlatformBackButton(color: Colors.black),
      actions: [
        IconButton(
          splashRadius: 20.0,
          onPressed: () => UrlLauncher.launchUrl(designPattern.mediumUrl),
          icon: const Icon(
            FontAwesomeIcons.medium,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
