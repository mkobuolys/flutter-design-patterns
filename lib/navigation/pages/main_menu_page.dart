import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/constants.dart';
import '../../data/models/design_pattern_category.dart';
import '../../data/repositories/design_pattern_categories_repository.dart';
import '../../helpers/helpers.dart';
import '../../modules/main_menu/widgets/main_menu_card.dart';
import '../../modules/main_menu/widgets/main_menu_header.dart';
import '../../themes.dart';

class MainMenuPage extends ConsumerWidget {
  const MainMenuPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designPatternCategories = ref.watch(designPatternCategoriesProvider);

    return Scaffold(
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: const ScrollBehavior(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(LayoutConstants.paddingL),
            child: Column(
              children: <Widget>[
                const MainMenuHeader(),
                const SizedBox(height: LayoutConstants.spaceXL),
                designPatternCategories.when(
                  data: (categories) => _MainMenuCardsListView(
                    categories: categories,
                  ),
                  loading: () => CircularProgressIndicator(
                    backgroundColor: lightBackgroundColor,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.black.withOpacity(0.65),
                    ),
                  ),
                  error: (_, __) => const Text('Oops, something went wrong...'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MainMenuCardsListView extends StatelessWidget {
  final List<DesignPatternCategory> categories;

  const _MainMenuCardsListView({
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > LayoutConstants.screenDesktop;
        final cardsIterable = categories.map<Widget>(
          (category) => MainMenuCard(category: category, isDesktop: isDesktop),
        );

        if (isDesktop) {
          return ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 500,
              maxWidth: 1500,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: cardsIterable
                  .map<Widget>((card) => Expanded(child: card))
                  .toList()
                  .addBetween(const SizedBox(width: LayoutConstants.spaceL)),
            ),
          );
        }

        return Column(
          children: cardsIterable
              .toList()
              .addBetween(const SizedBox(height: LayoutConstants.spaceL)),
        );
      },
    );
  }
}
