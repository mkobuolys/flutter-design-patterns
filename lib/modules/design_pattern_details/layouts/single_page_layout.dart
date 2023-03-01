import 'package:flutter/material.dart';

import '../../../../constants/layout_constants.dart';
import '../../../../data/models/design_pattern.dart';
import '../widgets/widgets.dart';

class SinglePageLayout extends StatelessWidget {
  const SinglePageLayout({
    required this.designPattern,
  });

  final DesignPattern designPattern;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DetailsAppBar(designPattern: designPattern),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: MarkdownView(designPattern: designPattern),
          ),
          const VerticalDivider(
            indent: LayoutConstants.spaceL,
            endIndent: LayoutConstants.spaceL,
          ),
          Expanded(
            child: ExampleView(designPatternId: designPattern.id),
          ),
        ],
      ),
    );
  }
}
