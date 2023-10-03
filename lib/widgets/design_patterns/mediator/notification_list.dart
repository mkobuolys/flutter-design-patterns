import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../design_patterns/mediator/mediator.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({
    required this.members,
    required this.onTap,
  });

  final List<TeamMember> members;
  final ValueSetter<TeamMember> onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Last notifications',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: LayoutConstants.spaceM),
        Text(
          'Note: click on the card to send a notification from the team member.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: LayoutConstants.spaceS),
        for (final member in members)
          Card(
            margin: const EdgeInsets.symmetric(
              vertical: LayoutConstants.marginS,
            ),
            child: InkWell(
              onTap: () => onTap(member),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: LayoutConstants.paddingM,
                  horizontal: LayoutConstants.paddingL,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            member.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: LayoutConstants.spaceS),
                          Text(member.lastNotification ?? '-'),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: LayoutConstants.paddingL),
                      child: Icon(Icons.message),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
