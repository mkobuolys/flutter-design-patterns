import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/constants.dart';

class CommandHistoryColumn extends StatelessWidget {
  final List<String> commandList;

  const CommandHistoryColumn({
    @required this.commandList,
  }) : assert(commandList != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Command history:',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: spaceS),
        if (commandList.isEmpty) const Text('Command history is empty.'),
        for (var i = 0; i < commandList.length; i++)
          Text('${i + 1}. ${commandList[i]}'),
      ],
    );
  }
}
