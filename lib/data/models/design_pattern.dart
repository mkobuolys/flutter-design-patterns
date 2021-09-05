class DesignPattern {
  final String id;
  final String title;
  final String description;

  const DesignPattern({
    required this.id,
    required this.title,
    required this.description,
  });

  factory DesignPattern.fromJson(Map<String, dynamic> json) {
    return DesignPattern(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }
}
