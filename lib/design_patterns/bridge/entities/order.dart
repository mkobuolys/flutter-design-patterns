import 'package:flutter_design_patterns/design_patterns/bridge/entities/entity_base.dart';

class Order extends EntityBase {
  final List<String> dishes;
  final double total;

  Order(this.dishes, this.total) : super();
}
