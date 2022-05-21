import 'package:flutter/foundation.dart';

abstract class Pizza {
  @protected
  late String description;

  String getDescription();
  double getPrice();
}
