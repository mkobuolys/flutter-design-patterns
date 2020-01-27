import 'package:faker/faker.dart';

import 'package:flutter_design_patterns/design_patterns/proxy/customer/customer_details.dart';

class Customer {
  String id;
  String name;
  CustomerDetails details;

  Customer() {
    id = faker.guid.guid();
    name = faker.person.name();
  }
}
