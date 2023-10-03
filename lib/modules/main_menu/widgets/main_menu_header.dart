import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../constants/constants.dart';
import '../../../../widgets/heartbeat_animation.dart';
import '../../../helpers/helpers.dart';
import '../../../widgets/logo_button.dart';

class MainMenuHeader extends StatelessWidget {
  const MainMenuHeader();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > LayoutConstants.screenDesktop;
        final headerText =
            isDesktop ? 'Flutter Design Patterns' : 'Flutter\nDesign Patterns';

        return Column(
          crossAxisAlignment:
              isDesktop ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: isDesktop
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  headerText,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(width: LayoutConstants.spaceS),
                const LogoButton(
                  onPressed:
                      UrlLauncher.launchFlutterDesignPatternsIntroductionPage,
                ),
              ],
            ),
            const SizedBox(height: LayoutConstants.spaceM),
            Row(
              mainAxisAlignment: isDesktop
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Created with Flutter and',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(width: LayoutConstants.spaceM),
                const Padding(
                  padding: EdgeInsets.only(bottom: LayoutConstants.paddingS),
                  child: HeartbeatAnimation(
                    child: Icon(
                      FontAwesomeIcons.solidHeart,
                      color: Color(0xFFF78888),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: LayoutConstants.spaceL),
            Text.rich(
              TextSpan(
                text: 'by ',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w500),
                children: [
                  TextSpan(
                    text: 'Mangirdas Kazlauskas',
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = UrlLauncher.launchPersonalPage,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
