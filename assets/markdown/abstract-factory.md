## Class diagram

![Abstract Factory Class Diagram](resource:assets/images/abstract_factory/abstract_factory.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of the **Abstract Factory** design pattern.

![Abstract Factory Implementation Class Diagram](resource:assets/images/abstract_factory/abstract_factory_implementation.png)

_IWidgetsFactory_ is an abstract class which is used as an interface for all the specific widget factories:

- _getTitle()_ - an abstract method which returns the title of the factory. Used in the UI;
- _createActivityIndicator()_ - an abstract method which returns the specific implementation (UI component/widget) of the activity (process) indicator implementing the _IActivityIndicator_ interface;
- _createSlider()_ - an abstract method which returns the specific implementation (UI component/widget) of the slider implementing the _ISlider_ interface;
- _createSwitch()_ - an abstract method which returns the specific implementation (UI component/widget) of the switch button implementing the _ISwitch_ interface.

_MaterialWidgetsFactory_ and _CupertinoWidgetsFactory_ are concrete classes which implement the _IWidgetsFactory_ class and its methods. _MaterialWidgetsFactory_ creates Material style components (widgets) while the _CupertinoWidgetsFactory_ creates Cupertino style widgets.

_IActivityIndicator_, _ISlider_ and _ISwitch_ are abstract classes which define the _render()_ method for each component. These classes are implemented by both - Material and Cupertino - widgets.

_AndroidActivityIndicator_, _AndroidSlider_ and _AndroidSwitch_ are concrete implementations of the Material widgets implementing the _render()_ method of corresponding interfaces.

_IosActivityIndicator_, _IosSlider_ and _IosSwitch_ are concrete implementations of the Cupertino widgets implementing the _render()_ method of corresponding interfaces.

_AbstractFactoryExample_ contains a list of factories implementing the _IWidgetsFactory_ interface. After selecting the specific factory, the example widget uses its methods to create the corresponding widgets/UI components.

### IWidgetsFactory

An interface which defines methods to be implemented by the specific factory classes. These methods are used to create components (widgets) of the specific type defined by the concrete factory. Dart language does not support the interface as a class type, so we define an interface by creating an abstract class and providing a method header (name, return type, parameters) without the default implementation.

```
abstract class IWidgetsFactory {
  String getTitle();
  IActivityIndicator createActivityIndicator();
  ISlider createSlider();
  ISwitch createSwitch();
}
```

### Widget factories

- _MaterialWidgetsFactory_ - a concrete factory class which implements the _IWidgetsFactory_ interface and its methods creating the Material style widgets.

```
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
```

- _CupertinoWidgetsFactory_ - a concrete factory class which implements the _IWidgetsFactory_ interface and its methods creating the Cupertino style widgets.

```
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
```

### IActivityIndicator

An interface which defines the _render()_ method to render the activity indicator component (widget).

```
abstract class IActivityIndicator {
  Widget render();
}
```

### Activity indicator widgets

- _AndroidActivityIndicator_ - a specific implementation of the activity indicator component returning the Material style widget _CircularProgressIndicator_.

```
class AndroidActivityIndicator implements IActivityIndicator {
  @override
  Widget render() {
    return CircularProgressIndicator(
      backgroundColor: Color(0xFFECECEC),
      valueColor: AlwaysStoppedAnimation<Color>(
        Colors.black.withOpacity(0.65),
      ),
    );
  }
}
```

- _IosActivityIndicator_ - a specific implementation of the activity indicator component returning the Cupertino style widget _CupertinoActivityIndicator_.

```
class IosActivityIndicator implements IActivityIndicator {
  @override
  Widget render() {
    return CupertinoActivityIndicator();
  }
}
```

### ISlider

An interface which defines the _render()_ method to render the slider component (widget).

```
abstract class ISlider {
  Widget render(double value, ValueSetter<double> onChanged);
}
```

### Slider widgets

- _AndroidSlider_ - a specific implementation of the slider component returning the Material style widget _Slider_.

```
class AndroidSlider implements ISlider {
  @override
  Widget render(double value, ValueSetter<double> onChanged) {
    return Slider(
      activeColor: Colors.black,
      inactiveColor: Colors.grey,
      min: 0.0,
      max: 100.0,
      value: value,
      onChanged: onChanged,
    );
  }
}
```

- _IosSlider_ - a specific implementation of the slider component returning the Cupertino style widget _CupertinoSlider_.

```
class IosSlider implements ISlider {
  @override
  Widget render(double value, ValueSetter<double> onChanged) {
    return CupertinoSlider(
      min: 0.0,
      max: 100.0,
      value: value,
      onChanged: onChanged,
    );
  }
}
```

### ISwitch

An interface which defines the _render()_ method to render the switch component (widget).

```
abstract class ISwitch {
  Widget render(bool value, ValueSetter<bool> onChanged);
}
```

### Switch widgets

- _AndroidSwitch_ - a specific implementation of the switch button component returning the Material style widget _Switch_.

```
class AndroidSwitch implements ISwitch {
  @override
  Widget render(bool value, ValueSetter<bool> onChanged) {
    return Switch(
      activeColor: Colors.black,
      value: value,
      onChanged: onChanged,
    );
  }
}
```

- _IosSwitch_ - a specific implementation of the switch button component returning the Cupertino style widget _CupertinoSwitch_.

```
class IosSwitch implements ISwitch {
  @override
  Widget render(bool value, ValueSetter<bool> onChanged) {
    return CupertinoSwitch(
      value: value,
      onChanged: onChanged,
    );
  }
}
```

### Example

_AbstractFactoryExample_ contains a list of _IWidgetsFactory_ objects (factories). After selecting the specific factory from the list, corresponding widgets are created using the factory methods and provided to the UI.

As you can see in the _build()_ method, the example widget does not care about the selected concrete factory as long as it implements the _IWidgetsFactory_ interface which methods return components implementing the corresponding common interfaces among all the factories and providing the _render()_ methods used in the UI. Also, the implementation of the specific widgets is encapsulated and defined in separate widget classes implementing the _render()_ method. Hence, the UI logic is not tightly coupled to any factory or component class which implementation details could be changed independently without affecting the implementation of the UI itself.

```
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
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: spaceXL),
            Text(
              'Process indicator',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(height: spaceL),
            _activityIndicator.render(),
            const SizedBox(height: spaceXL),
            Text(
              'Slider ($_sliderValueString%)',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(height: spaceL),
            _slider.render(_sliderValue, _setSliderValue),
            const SizedBox(height: spaceXL),
            Text(
              'Switch ($_switchValueString)',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(height: spaceL),
            _switch.render(_switchValue, _setSwitchValue),
          ],
        ),
      ),
    );
  }
}
```
