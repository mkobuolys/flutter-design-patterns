import 'package:flutter/widgets.dart';

abstract interface class ISlider {
  Widget render(double value, ValueSetter<double> onChanged);
}
