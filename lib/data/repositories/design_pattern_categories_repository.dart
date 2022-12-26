import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../constants/constants.dart';
import '../models/design_pattern.dart';
import '../models/design_pattern_category.dart';

part 'design_pattern_categories_repository.g.dart';

@riverpod
DesignPatternCategoriesRepository designPatternCategoriesRepository(_) {
  return const DesignPatternCategoriesRepository();
}

@riverpod
Future<List<DesignPatternCategory>> designPatternCategories(
  DesignPatternCategoriesRef ref,
) {
  final repository = ref.watch(designPatternCategoriesRepositoryProvider);

  return repository.get();
}

@riverpod
Future<DesignPattern> designPattern(DesignPatternRef ref, String id) async {
  final categories = await ref.watch(designPatternCategoriesProvider.future);

  return categories
      .expand((category) => category.patterns)
      .firstWhere((pattern) => pattern.id == id);
}

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
