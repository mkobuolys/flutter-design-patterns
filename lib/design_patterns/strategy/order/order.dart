import 'package:flutter_design_patterns/design_patterns/strategy/order/order_item.dart';

class Order {
  final List<OrderItem> items = List<OrderItem>();

  double get price =>
      items.fold(0.0, (sum, orderItem) => sum + orderItem.price);

  void addOrderItem(OrderItem orderItem) {
    items.add(orderItem);
  }
}
