import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/design_patterns/memento/command_design_pattern/shape.dart';
import 'package:flutter_design_patterns/design_patterns/memento/originator.dart';

class ShapeContainer extends StatelessWidget {
  final Originator originator;

  const ShapeContainer({
    @required this.originator,
  }) : assert(originator != null);

  Shape get _shape => originator.state;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160.0,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          height: _shape.height,
          width: _shape.width,
          decoration: BoxDecoration(
            color: _shape.color,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Icon(
            Icons.star,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
