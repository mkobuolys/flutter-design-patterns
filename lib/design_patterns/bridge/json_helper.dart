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

    return switch (T) {
      const (Customer) => Customer.fromJson(json) as T,
      const (Order) => Order.fromJson(json) as T,
      _ => throw Exception("Type of '$T' is not supported."),
    };
  }
}
