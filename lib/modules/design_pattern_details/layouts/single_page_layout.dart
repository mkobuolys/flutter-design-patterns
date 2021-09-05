import 'package:flutter/material.dart';

import '../../../../constants/layout_constants.dart';
import '../../../../data/models/design_pattern.dart';
import '../widgets/widgets.dart';

class SinglePageLayout extends StatelessWidget {
  final DesignPattern designPattern;

  const SinglePageLayout({
    required this.designPattern,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DetailsAppBar(title: designPattern.title),
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
