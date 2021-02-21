import '../iwidgets_factory.dart';
import '../widgets/activity_indicators/ios_activity_indicator.dart';
import '../widgets/iactivity_indicator.dart';
import '../widgets/islider.dart';
import '../widgets/iswitch.dart';
import '../widgets/sliders/ios_slider.dart';
import '../widgets/switches/ios_switch.dart';

class CupertinoWidgetsFactory implements IWidgetsFactory {
  @override
  String getTitle() {
    return 'iOS widgets';
  }

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
