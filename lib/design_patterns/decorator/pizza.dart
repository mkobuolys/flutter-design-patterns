import 'package:meta/meta.dart';

abstract class Pizza {
  @protected
  late String description;

  String getDescription();
  double getPrice();
}
