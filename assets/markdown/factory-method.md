## Class diagram

![Factory Method Class Diagram](resource:assets/images/factory_method/factory_method.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of the **Factory Method** design pattern.

![Factory Method Implementation Class Diagram](resource:assets/images/factory_method/factory_method_implementation.png)

`CustomDialog` is an abstract class that is used as a base class for all the specific alert dialogs:

- `getTitle()` - an abstract method which returns the title of the alert dialog. Used in the UI;
- `create()` - an abstract method which returns the specific implementation (UI component/widget) of the alert dialog;
- `show()` - calls the `create()` method to build (create) the alert dialog and show it in the UI.

`AndroidAlertDialog` and `IosAlertDialog` are concrete classes which extend the `CustomDialog` class and implement its abstract methods. `AndroidAlertDialog` creates a Material style alert dialog of type `AlertDialog` while the `IosAlertDialog` creates a Cupertino style alert dialog of type `CupertinoAlertDialog`.

`Widget`, `CupertinoAlertDialog` and `AlertDialog` are already implemented classes (widgets) of the Flutter library.

`FactoryMethodExample` contains the `CustomDialog` class to show the specific alert dialog of that type using the `show()` method.

### CustomDialog

An abstract class for showing custom dialogs. `CustomDialog` class implements the main logic to show the dialog (`show()` method). For the dialog creation itself, only the header of `create()` method is provided and every specific class extending the `CustomDialog` should implement it by returning a custom `Widget` object of that particular alert dialog.

```dart
abstract class CustomDialog {
  const CustomDialog();

  String getTitle();
  Widget create(BuildContext context);

  Future<void> show(BuildContext context) => showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: create,
      );
}
```

### Alert dialogs

- `AndroidAlertDialog` - a concrete alert dialog class that extends the `CustomDialog` and implements the `create()` method by using the Material `AlertDialog` widget.

```dart
class AndroidAlertDialog extends CustomDialog {
  const AndroidAlertDialog();

  @override
  String getTitle() => 'Android Alert Dialog';

  @override
  Widget create(BuildContext context) {
    return AlertDialog(
      title: Text(getTitle()),
      content: const Text('This is the material-style alert dialog!'),
      actions: <Widget>[
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Close'),
        ),
      ],
    );
  }
}
```

- `IosAlertDialog` - a concrete alert dialog class that extends the `CustomDialog` and implements the `create()` method by using the Cupertino (iOS) `CupertinoAlertDialog` widget.

```dart
class IosAlertDialog extends CustomDialog {
  const IosAlertDialog();

  @override
  String getTitle() => 'iOS Alert Dialog';

  @override
  Widget create(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(getTitle()),
      content: const Text('This is the cupertino-style alert dialog!'),
      actions: <Widget>[
        CupertinoButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Close'),
        ),
      ],
    );
  }
}
```

### Example

`FactoryMethodExample` contains a list of `CustomDialog` objects. After selecting the specific dialog from the list and triggering the `showCustomDialog()` method, a selected dialog is shown by calling the `show()` method on it.
As you can see in the `showCustomDialog()` method, it does not care about the specific implementation of the alert dialog as long as it extends the `CustomDialog` class and provides the `show()` method. Also, the implementation of the dialog widget is encapsulated and defined in a separate factory method (inside the specific implementation of `CustomDialog` class - `create()` method). Hence, the UI logic is not tightly coupled to any specific alert dialog class which implementation details could be changed independently without affecting the implementation of the UI itself.

```dart
class FactoryMethodExample extends StatefulWidget {
  const FactoryMethodExample();

  @override
  _FactoryMethodExampleState createState() => _FactoryMethodExampleState();
}

class _FactoryMethodExampleState extends State<FactoryMethodExample> {
  final List<CustomDialog> customDialogList = const [
    AndroidAlertDialog(),
    IosAlertDialog(),
  ];

  var _selectedDialogIndex = 0;

  Future _showCustomDialog(BuildContext context) async {
    final selectedDialog = customDialogList[_selectedDialogIndex];

    await selectedDialog.show(context);
  }

  void _setSelectedDialogIndex(int? index) {
    if (index == null) return;

    setState(() => _selectedDialogIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: LayoutConstants.paddingL,
        ),
        child: Column(
          children: <Widget>[
            DialogSelection(
              customDialogList: customDialogList,
              selectedIndex: _selectedDialogIndex,
              onChanged: _setSelectedDialogIndex,
            ),
            const SizedBox(height: LayoutConstants.spaceL),
            PlatformButton(
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: () => _showCustomDialog(context),
              text: 'Show Dialog',
            ),
          ],
        ),
      ),
    );
  }
}
```
