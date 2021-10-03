import 'dart:convert';

import 'entities/customer.dart';
import 'entities/entity_base.dart';
import 'entities/order.dart';

class JsonHelper {
  const JsonHelper._();

  static String serialiseObject(EntityBase entityBase) {
    return jsonEncode(entityBase);
  }

  static T deserialiseObject<T extends EntityBase>(String jsonString) {
    final json = jsonDecode(jsonString)! as Map<String, dynamic>;

    switch (T) {
      case Customer:
        return Customer.fromJson(json) as T;
      case Order:
        return Order.fromJson(json) as T;
      default:
        throw Exception("Type of '$T' is not supported.");
    }
  }
}
