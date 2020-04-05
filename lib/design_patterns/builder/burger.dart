import 'package:meta/meta.dart';

import 'package:flutter_design_patterns/design_patterns/builder/ingredient.dart';

class Burger {
  final double price;
  final List<Ingredient> _ingredients = [];

  Burger({@required this.price}) : assert(price != null);

  void addIngredient(Ingredient ingredient) {
    _ingredients.add(ingredient);
  }

  String getFormattedIngredients() {
    return _ingredients.map((x) => x.getName()).join(', ');
  }

  String getFormattedAllergens() {
    var allergens = Set<String>();

    _ingredients.forEach((x) => allergens.addAll(x.getAllergens()));

    return allergens.join(', ');
  }

  String getFormattedPrice() {
    return '\$${price.toStringAsFixed(2)}';
  }
}
