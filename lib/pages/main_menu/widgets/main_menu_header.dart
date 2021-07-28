import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/constants.dart';
import '../../../widgets/heartbeat_animation.dart';

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
            Text(
              headerText,
              style: Theme.of(context).textTheme.headline4,
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
          ],
        );
      },
    );
  }
}
