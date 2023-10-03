import 'package:flutter/widgets.dart';

import '../../../design_patterns/chain_of_responsibility/chain_of_responsibility.dart';

class LogMessagesColumn extends StatelessWidget {
  final List<LogMessage> logMessages;

  const LogMessagesColumn({
    required this.logMessages,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (final logMessage in logMessages)
          Row(
            children: <Widget>[
              Expanded(child: logMessage.getFormattedMessage()),
            ],
          ),
      ],
    );
  }
}
