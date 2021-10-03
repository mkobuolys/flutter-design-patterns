import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../constants/constants.dart';
import '../../../../widgets/heartbeat_animation.dart';
import '../../../helpers/helpers.dart';

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
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(width: LayoutConstants.spaceS),
                IconButton(
                  splashRadius: 20.0,
                  onPressed: () => UrlLauncher.launchUrl(
                    'https://mkobuolys.medium.com/flutter-design-patterns-0-introduction-5e88cfff6792',
                  ),
                  icon: const Icon(
                    FontAwesomeIcons.medium,
                    color: Colors.black,
                  ),
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
                  style: Theme.of(context).textTheme.headline5,
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
            RichText(
              text: TextSpan(
                text: 'Creator: ',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                children: [
                  TextSpan(
                    text: 'Mangirdas Kazlauskas',
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => UrlLauncher.launchUrl(
                            'https://linktr.ee/mkobuolys',
                          ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
