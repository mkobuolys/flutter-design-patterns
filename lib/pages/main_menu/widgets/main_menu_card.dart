import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_design_patterns/data/models/design_pattern_category.dart';
import 'package:flutter_design_patterns/pages/category/category_page.dart';
import 'package:flutter_design_patterns/widgets/selection_card.dart';

class MainMenuCard extends StatelessWidget {
  final DesignPatternCategory category;

  const MainMenuCard({
    @required this.category,
  }) : assert(category != null);

  @override
  Widget build(BuildContext context) {
    return SelectionCard(
      backgroundColor: Color(category.color),
      backgroundHeroTag: '${category.id}_background',
      contentHeader: Text(
        category.title,
        style: Theme.of(context).textTheme.headline6.copyWith(
              fontSize: 26.0,
              color: Colors.white,
            ),
        overflow: TextOverflow.ellipsis,
      ),
      contentText: Text(
        category.patterns.length == 1
            ? '${category.patterns.length} pattern'
            : '${category.patterns.length} patterns',
        style: Theme.of(context).textTheme.subtitle1.copyWith(
              color: Colors.white,
            ),
      ),
      onTap: () => Navigator.pushNamed(
        context,
        CategoryPage.route,
        arguments: category,
      ),
    );
  }
}
