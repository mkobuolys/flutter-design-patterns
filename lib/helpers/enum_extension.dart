extension XString on String {
  /// ### returns `Enum` from `String` by matching it from enum.values
  T toEnum<T extends Enum>(List<T> values) =>
      values.firstWhere((e) => e.name == this);
}
