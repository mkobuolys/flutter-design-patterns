import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../data/models/design_pattern.dart';
import '../../../widgets/selection_card.dart';

class DesignPatternCard extends StatelessWidget {
  final DesignPattern designPattern;

  const DesignPatternCard({
    required this.designPattern,
  });

  @override
  Widget build(BuildContext context) {
    return SelectionCard(
      backgroundColor: lightBackgroundColor,
      contentHeader: Text(
        designPattern.title,
        style: Theme.of(context).textTheme.headline6!.copyWith(
              fontSize: 26.0,
            ),
        overflow: TextOverflow.ellipsis,
      ),
      contentText: Text(
        designPattern.description,
        style: Theme.of(context).textTheme.bodyText2,
        textAlign: TextAlign.justify,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
      onTap: () => Navigator.pushNamed(
        context,
        designPattern.route,
        arguments: designPattern,
      ),
    );
  }
}
