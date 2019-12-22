import 'package:flutter_design_patterns/design_patterns/abstract_factory/widgets/iactivity_indicator.dart';
import 'package:flutter_design_patterns/design_patterns/abstract_factory/widgets/islider.dart';
import 'package:flutter_design_patterns/design_patterns/abstract_factory/widgets/iswitch.dart';

abstract class IWidgetsFactory {
  IActivityIndicator createActivityIndicator();
  ISlider createSlider();
  ISwitch createSwitch();
}
