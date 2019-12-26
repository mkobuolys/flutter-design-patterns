import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/constants.dart';
import 'package:flutter_design_patterns/design_patterns/abstract_factory/factories/cupertino_widgets_factory.dart';
import 'package:flutter_design_patterns/design_patterns/abstract_factory/factories/material_widgets_factory.dart';
import 'package:flutter_design_patterns/design_patterns/abstract_factory/iwidgets_factory.dart';
import 'package:flutter_design_patterns/design_patterns/abstract_factory/widgets/iactivity_indicator.dart';
import 'package:flutter_design_patterns/design_patterns/abstract_factory/widgets/islider.dart';
import 'package:flutter_design_patterns/design_patterns/abstract_factory/widgets/iswitch.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/abstract_factory/factory_selection.dart';

class AbstractFactoryExample extends StatefulWidget {
  @override
  _AbstractFactoryExampleState createState() => _AbstractFactoryExampleState();
}

class _AbstractFactoryExampleState extends State<AbstractFactoryExample> {
  final List<IWidgetsFactory> widgetsFactoryList = [
    MaterialWidgetsFactory(),
    CupertinoWidgetsFactory(),
  ];

  int _selectedFactoryIndex = 0;

  IActivityIndicator _activityIndicator;

  ISlider _slider;
  double _sliderValue = 50.0;
  String get _sliderValueString => _sliderValue.toStringAsFixed(0);

  ISwitch _switch;
  bool _switchValue = false;
  String get _switchValueString => _switchValue ? 'ON' : 'OFF';

  @override
  void initState() {
    super.initState();
    _createWidgets();
  }

  void _createWidgets() {
    _activityIndicator =
        widgetsFactoryList[_selectedFactoryIndex].createActivityIndicator();
    _slider = widgetsFactoryList[_selectedFactoryIndex].createSlider();
    _switch = widgetsFactoryList[_selectedFactoryIndex].createSwitch();
  }

  void _setSelectedFactoryIndex(int index) {
    setState(() {
      _selectedFactoryIndex = index;
      _createWidgets();
    });
  }

  void _setSliderValue(double value) {
    setState(() {
      _sliderValue = value;
    });
  }

  void _setSwitchValue(bool value) {
    setState(() {
      _switchValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: paddingL),
        child: Column(
          children: <Widget>[
            FactorySelection(
              widgetsFactoryList: widgetsFactoryList,
              selectedIndex: _selectedFactoryIndex,
              onChanged: _setSelectedFactoryIndex,
            ),
            const SizedBox(height: spaceL),
            Text(
              'Widgets showcase',
              style: Theme.of(context).textTheme.title,
            ),
            const SizedBox(height: spaceXL),
            Text(
              'Process indicator',
              style: Theme.of(context).textTheme.subhead,
            ),
            const SizedBox(height: spaceL),
            _activityIndicator.render(),
            const SizedBox(height: spaceXL),
            Text(
              'Slider ($_sliderValueString%)',
              style: Theme.of(context).textTheme.subhead,
            ),
            const SizedBox(height: spaceL),
            _slider.render(_sliderValue, _setSliderValue),
            const SizedBox(height: spaceXL),
            Text(
              'Switch ($_switchValueString)',
              style: Theme.of(context).textTheme.subhead,
            ),
            const SizedBox(height: spaceL),
            _switch.render(_switchValue, _setSwitchValue),
          ],
        ),
      ),
    );
  }
}
