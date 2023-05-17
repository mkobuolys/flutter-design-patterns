import '../iwidgets_factory.dart';
import '../widgets/activity_indicators/android_activity_indicator.dart';
import '../widgets/iactivity_indicator.dart';
import '../widgets/islider.dart';
import '../widgets/iswitch.dart';
import '../widgets/sliders/android_slider.dart';
import '../widgets/switches/android_switch.dart';

class MaterialWidgetsFactory implements IWidgetsFactory {
  const MaterialWidgetsFactory();

  @override
  String getTitle() => 'Android widgets';

  @override
  IActivityIndicator createActivityIndicator() =>
      const AndroidActivityIndicator();

  @override
  ISlider createSlider() => const AndroidSlider();

  @override
  ISwitch createSwitch() => const AndroidSwitch();
}
