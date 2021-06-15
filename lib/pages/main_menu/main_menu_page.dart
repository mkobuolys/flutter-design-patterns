import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/constants.dart';
import '../../data/models/design_pattern_category.dart';
import '../../data/repositories/design_pattern_categories_repository.dart';
import '../../helpers/index.dart';
import '../../themes.dart';
import 'widgets/main_menu_card.dart';
import 'widgets/main_menu_header.dart';

class MainMenuPage extends StatelessWidget {
  const MainMenuPage();

  @override
  Widget build(BuildContext context) {
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
                Consumer(
                  builder: (context, watch, child) {
                    final repository =
                        watch(designPatternCategoriesRepositoryProvider);

                    return FutureBuilder<List<DesignPatternCategory>>(
                      future: repository.get(),
                      initialData: const [],
                      builder: (
                        _,
                        AsyncSnapshot<List<DesignPatternCategory>> snapshot,
                      ) {
                        if (snapshot.hasData) {
                          return _MainMenuCardsListView(
                            categories: snapshot.data!,
                          );
                        }

                        return CircularProgressIndicator(
                          backgroundColor: lightBackgroundColor,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.black.withOpacity(0.65),
                          ),
                        );
                      },
                    );
                  },
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
        final flexFactor = isDesktop ? 1 : 0;
        final flexDirection = isDesktop ? Axis.horizontal : Axis.vertical;
        const divider = SizedBox(
          height: LayoutConstants.spaceL,
          width: LayoutConstants.spaceL,
        );

        return Flex(
          crossAxisAlignment: CrossAxisAlignment.start,
          direction: flexDirection,
          children: <Widget>[
            for (var category in categories)
              Flexible(
                flex: flexFactor,
                child: MainMenuCard(
                  category: category,
                  isDesktop: isDesktop,
                ),
              )
          ].addBetween(divider),
        );
      },
    );
  }
}
