import 'design_pattern.dart';

class DesignPatternCategory {
  const DesignPatternCategory({
    required this.id,
    required this.title,
    required this.color,
    required this.patterns,
  });

  final String id;
  final String title;
  final int color;
  final List<DesignPattern> patterns;

  factory DesignPatternCategory.fromJson(Map<String, dynamic> json) {
    final designPatternJsonList = json['patterns'] as List;
    final designPatternList = designPatternJsonList
        .map(
          (designPatternJson) => DesignPattern.fromJson(
            designPatternJson as Map<String, dynamic>,
          ),
        )
        .toList();

    return DesignPatternCategory(
      id: json['id'] as String,
      title: json['title'] as String,
      color: int.parse(json['color'] as String),
      patterns: designPatternList,
    );
  }
}
