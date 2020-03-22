import 'package:flutter_design_patterns/design_patterns/bridge/entities/entity_base.dart';

class Customer extends EntityBase {
  final String name;
  final String email;

  Customer(this.name, this.email) : super();
}
