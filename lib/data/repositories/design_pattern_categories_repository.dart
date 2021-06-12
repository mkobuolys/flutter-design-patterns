import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/constants.dart';
import '../models/design_pattern_category.dart';

final designPatternCategoriesRepositoryProvider = Provider(
  (ref) => const DesignPatternCategoriesRepository(),
);

class DesignPatternCategoriesRepository {
  const DesignPatternCategoriesRepository();

  Future<List<DesignPatternCategory>> get() async {
    final menuJson = await rootBundle.loadString(
      AssetConstants.designPatternsJsonPath,
    );
    final designPatternCategoryJsonList = json.decode(menuJson) as List;
    final mainMenuSections = designPatternCategoryJsonList
        .map((categoryJson) => DesignPatternCategory.fromJson(
            categoryJson as Map<String, dynamic>))
        .toList();

    return mainMenuSections;
  }
}
