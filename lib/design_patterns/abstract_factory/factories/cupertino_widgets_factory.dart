import '../iwidgets_factory.dart';
import '../widgets/activity_indicators/ios_activity_indicator.dart';
import '../widgets/iactivity_indicator.dart';
import '../widgets/islider.dart';
import '../widgets/iswitch.dart';
import '../widgets/sliders/ios_slider.dart';
import '../widgets/switches/ios_switch.dart';

class CupertinoWidgetsFactory implements IWidgetsFactory {
  const CupertinoWidgetsFactory();

  @override
  String getTitle() => 'iOS widgets';

  @override
  IActivityIndicator createActivityIndicator() => const IosActivityIndicator();

  @override
  ISlider createSlider() => const IosSlider();

  @override
  ISwitch createSwitch() => const IosSwitch();
}
