import 'package:faker/faker.dart';

import 'package:flutter_design_patterns/design_patterns/bridge/entities/entity_base.dart';

class Customer extends EntityBase {
  String name;
  String email;

  Customer() : super() {
    name = faker.person.name();
    email = faker.internet.email();
  }

  Customer.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        super.fromJson(json);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
      };
}
