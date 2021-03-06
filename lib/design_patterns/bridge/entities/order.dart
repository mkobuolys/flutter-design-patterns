import 'package:faker/faker.dart';

import 'entity_base.dart';

class Order extends EntityBase {
  late List<String> dishes;
  late double total;

  Order() : super() {
    dishes = List.generate(random.integer(3, min: 1), (_) => faker.food.dish());
    total = random.decimal(scale: 20, min: 5);
  }

  Order.fromJson(Map<String, dynamic> json)
      : dishes = List.from(json['dishes'] as List),
        total = json['total'] as double,
        super.fromJson(json);

  Map<String, dynamic> toJson() => {
        'id': id,
        'dishes': dishes,
        'total': total,
      };
}
