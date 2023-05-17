import 'widgets/iactivity_indicator.dart';
import 'widgets/islider.dart';
import 'widgets/iswitch.dart';

abstract interface class IWidgetsFactory {
  String getTitle();
  IActivityIndicator createActivityIndicator();
  ISlider createSlider();
  ISwitch createSwitch();
}
