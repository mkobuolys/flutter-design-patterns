import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/constants.dart';
import 'package:flutter_design_patterns/design_patterns/prototype/shape.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/prototype/shape_column/sized_shape_column.dart';
import 'package:flutter_design_patterns/widgets/platform_specific/platform_button.dart';

class ShapeColumn extends StatelessWidget {
  final Shape shape;
  final Shape shapeClone;
  final VoidCallback onRandomisePropertiesPressed;
  final VoidCallback onClonePressed;

  const ShapeColumn({
    @required this.shape,
    @required this.shapeClone,
    @required this.onRandomisePropertiesPressed,
    @required this.onClonePressed,
  })  : assert(shape != null),
        assert(onRandomisePropertiesPressed != null),
        assert(onClonePressed != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedShapeColumn(
              label: 'Original shape',
              child: shape.render(),
            ),
            const SizedBox(width: spaceM),
            SizedShapeColumn(
              label: 'Cloned shape',
              child: shapeClone == null
                  ? SizedBox(
                      height: 120.0,
                      width: 120.0,
                      child: Placeholder(),
                    )
                  : shapeClone.render(),
            ),
          ],
        ),
        PlatformButton(
          child: Text('Randomise properties'),
          materialColor: Colors.black,
          materialTextColor: Colors.white,
          onPressed: onRandomisePropertiesPressed,
        ),
        PlatformButton(
          child: Text('Clone'),
          materialColor: Colors.black,
          materialTextColor: Colors.white,
          onPressed: onClonePressed,
        ),
      ],
    );
  }
}
