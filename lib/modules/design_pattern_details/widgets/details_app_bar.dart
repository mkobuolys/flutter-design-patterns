import 'dart:async';

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
  }) : compact = false;

  const DetailsAppBar.compact({
    required this.designPattern,
  }) : compact = true;

  final DesignPattern designPattern;
  final bool compact;

  void _openArticle() {
    unawaited(UrlLauncher.launchUrl(designPattern.articleUrl));
  }

  @override
  Widget build(BuildContext context) {
    const color = Colors.black;

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: lightBackgroundColor,
      leading: !kIsWeb ? const PlatformBackButton(color: color) : null,
      title: Text(
        designPattern.title,
        style: const TextStyle(color: color),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: LayoutConstants.paddingM),
          child: !compact
              ? TextButton.icon(
                  onPressed: _openArticle,
                  icon: Image.asset('assets/images/logo.png', width: 24.0),
                  label: Row(
                    children: [
                      Text(
                        'Read blog post',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: color),
                      ),
                      const SizedBox(width: LayoutConstants.spaceM),
                      const Icon(Icons.open_in_new, size: 16.0, color: color),
                    ],
                  ),
                )
              : LogoButton(onPressed: _openArticle),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
