import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/constants.dart';

class Box extends StatelessWidget {
  final int nodeId;
  final Color color;
  final Widget child;

  const Box({
    @required this.nodeId,
    @required this.color,
    this.child,
  })  : assert(nodeId != null),
        assert(color != null);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(paddingM),
        child: Column(
          children: <Widget>[
            Text(
              nodeId.toString(),
              style: Theme.of(context).textTheme.title,
            ),
            const SizedBox(height: spaceM),
            if (child != null) child,
          ],
        ),
      ),
    );
  }
}
