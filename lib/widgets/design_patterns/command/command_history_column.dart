import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class CommandHistoryColumn extends StatelessWidget {
  final List<String> commandList;

  const CommandHistoryColumn({
    required this.commandList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Command history:', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: LayoutConstants.spaceS),
        if (commandList.isEmpty) const Text('Command history is empty.'),
        for (final (i, command) in commandList.indexed)
          Text('${i + 1}. $command'),
      ],
    );
  }
}
