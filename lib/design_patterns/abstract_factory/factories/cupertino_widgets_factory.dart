import 'package:flutter_design_patterns/design_patterns/abstract_factory/iwidgets_factory.dart';
import 'package:flutter_design_patterns/design_patterns/abstract_factory/widgets/activity_indicators/ios_activity_indicator.dart';
import 'package:flutter_design_patterns/design_patterns/abstract_factory/widgets/iactivity_indicator.dart';
import 'package:flutter_design_patterns/design_patterns/abstract_factory/widgets/islider.dart';
import 'package:flutter_design_patterns/design_patterns/abstract_factory/widgets/iswitch.dart';
import 'package:flutter_design_patterns/design_patterns/abstract_factory/widgets/sliders/ios_slider.dart';
import 'package:flutter_design_patterns/design_patterns/abstract_factory/widgets/switches/ios_switch.dart';

class CupertinoWidgetsFactory implements IWidgetsFactory {
  @override
  IActivityIndicator createActivityIndicator() {
    return IosActivityIndicator();
  }

  @override
  ISlider createSlider() {
    return IosSlider();
  }

  @override
  ISwitch createSwitch() {
    return IosSwitch();
  }
}
