import 'dart:convert';

import 'entities/customer.dart';
import 'entities/entity_base.dart';
import 'entities/order.dart';

class JsonHelper {
  static String serialiseObject(EntityBase entityBase) {
    return jsonEncode(entityBase);
  }

  static EntityBase deserialiseObject<T extends EntityBase>(String jsonString) {
    final json = jsonDecode(jsonString);

    switch (T) {
      case Customer:
        return Customer.fromJson(json as Map<String, dynamic>);
      case Order:
        return Order.fromJson(json as Map<String, dynamic>);
      default:
        throw Exception("Type of '$T' is not supported.");
    }
  }
}
