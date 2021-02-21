import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../data/models/design_pattern_category.dart';
import '../../data/repositories/design_pattern_categories_repository.dart';
import 'widgets/main_menu_card.dart';
import 'widgets/main_menu_header.dart';

class MainMenuPage extends StatelessWidget {
  static const String route = '/main-menu';

  final DesignPatternCategoriesRepository repository =
      DesignPatternCategoriesRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: const ScrollBehavior(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(paddingL),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                MainMenuHeader(),
                FutureBuilder<List<DesignPatternCategory>>(
                  future: repository.get(),
                  initialData: const [],
                  builder: (
                    _,
                    AsyncSnapshot<List<DesignPatternCategory>> snapshot,
                  ) {
                    if (snapshot.hasData) {
                      return Column(
                        children: <Widget>[
                          for (var category in snapshot.data)
                            Container(
                              margin: const EdgeInsets.only(top: marginL),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
