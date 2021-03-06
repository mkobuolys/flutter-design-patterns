import 'package:meta/meta.dart';

abstract class Ingredient {
  @protected
  late List<String> allergens;
  @protected
  late String name;

  List<String> getAllergens() {
    return allergens;
  }

  String getName() {
    return name;
  }
}
