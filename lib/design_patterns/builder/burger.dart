import 'ingredient.dart';

class Burger {
  final List<Ingredient> _ingredients = [];
  late double _price;

  void addIngredient(Ingredient ingredient) {
    _ingredients.add(ingredient);
  }

  String getFormattedIngredients() {
    return _ingredients.map((x) => x.getName()).join(', ');
  }

  String getFormattedAllergens() {
    final allergens = <String>{};

    for (final ingredient in _ingredients) {
      allergens.addAll(ingredient.getAllergens());
    }

    return allergens.join(', ');
  }

  String getFormattedPrice() {
    return '\$${_price.toStringAsFixed(2)}';
  }

  // ignore: use_setters_to_change_properties
  void setPrice(double price) {
    _price = price;
  }
}
