import 'package:faker/faker.dart';

import 'package:flutter_design_patterns/design_patterns/bridge/entities/entity_base.dart';

class Order extends EntityBase {
  List<String> dishes;
  double total;

  Order() : super() {
    dishes = List.generate(random.integer(3, min: 1), (_) => faker.food.dish());
    total = random.decimal(scale: 20, min: 5);
  }

  Order.fromJson(Map<String, dynamic> json)
      : dishes = List.from(json['dishes']),
        total = json['total'],
        super.fromJson(json);

  Map<String, dynamic> toJson() => {
        'id': id,
        'dishes': dishes,
        'total': total,
      };
}
