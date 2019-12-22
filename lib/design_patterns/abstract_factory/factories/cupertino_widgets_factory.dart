import 'package:flutter_design_patterns/design_patterns/abstract_factory/iwidgets_factory.dart';
import 'package:flutter_design_patterns/design_patterns/abstract_factory/widgets/iactivity_indicator.dart';
import 'package:flutter_design_patterns/design_patterns/abstract_factory/widgets/islider.dart';
import 'package:flutter_design_patterns/design_patterns/abstract_factory/widgets/iswitch.dart';

class CupertinoWidgetsFactory implements IWidgetsFactory {
  @override
  IActivityIndicator createActivityIndicator() {
    // TODO: implement createActivityIndicator
    return null;
  }

  @override
  ISlider createSlider() {
    // TODO: implement createSlider
    return null;
  }

  @override
  ISwitch createSwitch() {
    // TODO: implement createSwitch
    return null;
  }
}
