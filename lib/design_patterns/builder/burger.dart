import 'ingredient.dart';

class Burger {
  final List<Ingredient> _ingredients = [];
  late double _price;

  void addIngredient(Ingredient ingredient) => _ingredients.add(ingredient);

  String getFormattedIngredients() =>
      _ingredients.map((x) => x.getName()).join(', ');

  String getFormattedAllergens() => <String>{
        for (final ingredient in _ingredients) ...ingredient.getAllergens(),
      }.join(', ');

  String getFormattedPrice() => '\$${_price.toStringAsFixed(2)}';

  // ignore: use_setters_to_change_properties
  void setPrice(double price) => _price = price;
}
