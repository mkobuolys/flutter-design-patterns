import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../widgets/heartbeat_animation.dart';

class MainMenuHeader extends StatelessWidget {
  const MainMenuHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: LayoutConstants.paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Flutter\nDesign Patterns',
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: LayoutConstants.spaceM),
          Row(
            children: <Widget>[
              Text(
                'Created with Flutter and',
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(width: LayoutConstants.spaceM),
              const Padding(
                padding: EdgeInsets.only(bottom: LayoutConstants.paddingS),
                child: HeartbeatAnimation(
                  child: Text(
                    '❤️',
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
