import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';
import '../../../../design_patterns/prototype/prototype.dart';
import '../../../platform_specific/platform_button.dart';
import 'sized_shape_column.dart';

class ShapeColumn extends StatelessWidget {
  final Shape shape;
  final Shape? shapeClone;
  final VoidCallback onRandomisePropertiesPressed;
  final VoidCallback onClonePressed;

  const ShapeColumn({
    required this.shape,
    required this.shapeClone,
    required this.onRandomisePropertiesPressed,
    required this.onClonePressed,
  });

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
            const SizedBox(width: LayoutConstants.spaceM),
            SizedShapeColumn(
              label: 'Cloned shape',
              child: shapeClone == null
                  ? const SizedBox(
                      height: 120.0,
                      width: 120.0,
                      child: Placeholder(),
                    )
                  : shapeClone!.render(),
            ),
          ],
        ),
        PlatformButton(
          materialColor: Colors.black,
          materialTextColor: Colors.white,
          onPressed: onRandomisePropertiesPressed,
          text: 'Randomise properties',
        ),
        PlatformButton(
          materialColor: Colors.black,
          materialTextColor: Colors.white,
          onPressed: onClonePressed,
          text: 'Clone',
        ),
      ],
    );
  }
}
