class PizzaToppingData {
  final String label;
  bool selected = false;

  PizzaToppingData(this.label);

  void setSelected(bool value) {
    selected = value;
  }
}
