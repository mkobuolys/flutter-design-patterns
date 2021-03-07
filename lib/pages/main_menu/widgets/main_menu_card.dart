import 'package:flutter/material.dart';

import '../../../data/models/design_pattern_category.dart';
import '../../../widgets/selection_card.dart';
import '../../category/category_page.dart';

class MainMenuCard extends StatelessWidget {
  final DesignPatternCategory category;

  const MainMenuCard({
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return SelectionCard(
      backgroundColor: Color(category.color),
      contentHeader: Text(
        category.title,
        style: Theme.of(context).textTheme.headline6!.copyWith(
              fontSize: 26.0,
              color: Colors.white,
            ),
        overflow: TextOverflow.ellipsis,
      ),
      contentText: Text(
        category.patterns.length == 1
            ? '${category.patterns.length} pattern'
            : '${category.patterns.length} patterns',
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
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
