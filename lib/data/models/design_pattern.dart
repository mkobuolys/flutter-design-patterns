class DesignPattern {
  final String id;
  final String title;
  final String description;
  final String articleUrl;

  const DesignPattern({
    required this.id,
    required this.title,
    required this.description,
    required this.articleUrl,
  });

  factory DesignPattern.fromJson(Map<String, dynamic> json) {
    return DesignPattern(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      articleUrl: json['articleUrl'] as String,
    );
  }
}
