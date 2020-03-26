import 'dart:convert';

import 'package:flutter_design_patterns/design_patterns/bridge/entities/customer.dart';
import 'package:flutter_design_patterns/design_patterns/bridge/entities/entity_base.dart';
import 'package:flutter_design_patterns/design_patterns/bridge/entities/order.dart';

class JsonHelper {
  static String serialiseObject(EntityBase entityBase) {
    return jsonEncode(entityBase);
  }

  static EntityBase deserialiseObject<T extends EntityBase>(String jsonString) {
    var json = jsonDecode(jsonString);

    switch (T) {
      case Customer:
        return Customer.fromJson(json);
      case Order:
        return Order.fromJson(json);
      default:
        throw Exception("Type of '$T' is not supported.");
    }
  }
}
