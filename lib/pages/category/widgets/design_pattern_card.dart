import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_design_patterns/constants.dart';
import 'package:flutter_design_patterns/data/models/design_pattern.dart';
import 'package:flutter_design_patterns/widgets/selection_card.dart';

class DesignPatternCard extends StatelessWidget {
  final DesignPattern designPattern;

  const DesignPatternCard({
    @required this.designPattern,
  }) : assert(designPattern != null);

  @override
  Widget build(BuildContext context) {
    return SelectionCard(
      backgroundColor: lightBackgroundColor,
      backgroundHeroTag: '${designPattern.id}_background',
      contentHeader: Text(
        designPattern.title,
        style: Theme.of(context).textTheme.headline6.copyWith(
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
