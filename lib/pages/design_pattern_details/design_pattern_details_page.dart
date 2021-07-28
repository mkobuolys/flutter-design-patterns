import 'package:flutter/widgets.dart';

import '../../constants/constants.dart';
import '../../data/models/design_pattern.dart';
import 'layouts/layouts.dart';

class DesignPatternDetailsPage extends StatelessWidget {
  final DesignPattern designPattern;
  final Widget example;

  const DesignPatternDetailsPage({
    required this.designPattern,
    required this.example,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > LayoutConstants.screenDesktop) {
          return SinglePageLayout(
            designPattern: designPattern,
            example: example,
          );
        }

        return TabsLayout(
          designPattern: designPattern,
          example: example,
        );
      },
    );
  }
}
