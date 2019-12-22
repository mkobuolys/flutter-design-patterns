import 'package:flutter/widgets.dart';

abstract class ISlider {
  Widget render(double value, ValueSetter<double> onChanged);
}
