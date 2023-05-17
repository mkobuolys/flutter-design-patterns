import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../themes.dart';
import '../../../../widgets/platform_specific/platform_back_button.dart';
import '../../../constants/constants.dart';
import '../../../data/models/design_pattern.dart';
import '../../../helpers/helpers.dart';
import '../../../widgets/logo_button.dart';

class DetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DetailsAppBar({
    required this.designPattern,
  });

  final DesignPattern designPattern;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: lightBackgroundColor,
      leading: !kIsWeb ? const PlatformBackButton(color: Colors.black) : null,
      title: Text(
        designPattern.title,
        style: const TextStyle(color: Colors.black),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: LayoutConstants.paddingM),
          child: LogoButton(
            onPressed: () => UrlLauncher.launchUrl(designPattern.articleUrl),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
