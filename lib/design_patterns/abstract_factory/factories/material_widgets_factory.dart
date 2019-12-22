import 'package:flutter_design_patterns/design_patterns/abstract_factory/iwidgets_factory.dart';
import 'package:flutter_design_patterns/design_patterns/abstract_factory/widgets/activity_indicators/android_activity_indicator.dart';
import 'package:flutter_design_patterns/design_patterns/abstract_factory/widgets/iactivity_indicator.dart';
import 'package:flutter_design_patterns/design_patterns/abstract_factory/widgets/islider.dart';
import 'package:flutter_design_patterns/design_patterns/abstract_factory/widgets/iswitch.dart';
import 'package:flutter_design_patterns/design_patterns/abstract_factory/widgets/sliders/android_slider.dart';
import 'package:flutter_design_patterns/design_patterns/abstract_factory/widgets/switches/android_switch.dart';

class MaterialWidgetsFactory implements IWidgetsFactory {
  @override
  String getTitle() {
    return 'Android widgets';
  }

  @override
  IActivityIndicator createActivityIndicator() {
    return AndroidActivityIndicator();
  }

  @override
  ISlider createSlider() {
    return AndroidSlider();
  }

  @override
  ISwitch createSwitch() {
    return AndroidSwitch();
  }
}
