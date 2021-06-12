import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/constants.dart';
import '../../data/models/design_pattern_category.dart';
import '../../data/repositories/design_pattern_categories_repository.dart';
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const MainMenuHeader(),
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
                          return Column(
                            children: <Widget>[
                              for (var category in snapshot.data!)
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: LayoutConstants.marginL),
                                  child: MainMenuCard(
                                    category: category,
                                  ),
                                )
                            ],
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
