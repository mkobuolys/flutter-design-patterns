import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_design_patterns/constants.dart';

class SizedShapeColumn extends StatelessWidget {
  final String label;
  final Widget child;

  const SizedShapeColumn({
    @required this.label,
    @required this.child,
  })  : assert(label != null),
        assert(child != null);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160.0,
      child: Column(
        children: <Widget>[
          Text(label),
          const SizedBox(height: spaceM),
          child,
        ],
      ),
    );
  }
}
