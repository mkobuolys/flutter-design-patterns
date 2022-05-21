import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/constants.dart';
import '../models/design_pattern.dart';
import '../models/design_pattern_category.dart';

final designPatternCategoriesRepositoryProvider = Provider(
  (ref) => const DesignPatternCategoriesRepository(),
);

final designPatternCategoriesProvider =
    FutureProvider<List<DesignPatternCategory>>(
  (ref) {
    final repository = ref.watch(designPatternCategoriesRepositoryProvider);

    return repository.get();
  },
);

final designPatternProvider =
    FutureProvider.autoDispose.family<DesignPattern, String>(
  (ref, id) async {
    final categories = await ref.watch(designPatternCategoriesProvider.future);

    return categories
        .expand((category) => category.patterns)
        .firstWhere((pattern) => pattern.id == id);
  },
);

class DesignPatternCategoriesRepository {
  const DesignPatternCategoriesRepository();

  Future<List<DesignPatternCategory>> get() async {
    final menuJson = await rootBundle.loadString(
      AssetConstants.designPatternsJsonPath,
    );
    final designPatternCategoryJsonList = json.decode(menuJson) as List;
    final mainMenuSections = designPatternCategoryJsonList
        .map(
          (categoryJson) => DesignPatternCategory.fromJson(
            categoryJson as Map<String, dynamic>,
          ),
        )
        .toList();

    return mainMenuSections;
  }
}
