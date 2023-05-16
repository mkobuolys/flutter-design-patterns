## Class diagram

![Factory Method Class Diagram](resource:assets/images/factory_method/factory_method.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of the **Factory Method** design pattern.

![Factory Method Implementation Class Diagram](resource:assets/images/factory_method/factory_method_implementation.png)

_CustomDialog_ is an abstract class which is used as a base class for all the specific alert dialogs:

- _getTitle()_ - an abstract method which returns the title of the alert dialog. Used in the UI;
- _create()_ - an abstract method which returns the specific implementation (UI component/widget) of the alert dialog;
- _show()_ - calls the _create()_ method to build (create) the alert dialog and show it in the UI.

_AndroidAlertDialog_ and _IosAlertDialog_ are concrete classes which extend the _CustomDialog_ class and implement its abstract methods. _AndroidAlertDialog_ creates a Material style alert dialog of type _AlertDialog_ while the _IosAlertDialog_ creates a Cupertino style alert dialog of type _CupertinoAlertDialog_.

_Widget_, _CupertinoAlertDialog_ and _AlertDialog_ are already implemented classes (widgets) of the Flutter library.

_FactoryMethodExample_ contains the _CustomDialog_ class to show the specific alert dialog of that type using the _show()_ method.

### CustomDialog

An abstract class for showing custom dialogs. _CustomDialog_ class implements the main logic to show the dialog (_show()_ method). For the dialog creation itself, only the header of _create()_ method is provided and every specific class extending the _CustomDialog_ should implement it by returning a custom _Widget_ object of that particular alert dialog.

```
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

- _AndroidAlertDialog_ - a concrete alert dialog class which extends the _CustomDialog_ and implements the _create()_ method by using the Material _AlertDialog_ widget.

```
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

- _IosAlertDialog_ - a concrete alert dialog class which extends the _CustomDialog_ and implements the _create()_ method by using the Cupertino (iOS) _CupertinoAlertDialog_ widget.

```
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

_FactoryMethodExample_ contains a list of _CustomDialog_ objects. After selecting the specific dialog from the list and triggering the _showCustomDialog()_ method, a selected dialog is shown by calling the _show()_ method on it.
As you can see in the _showCustomDialog()_ method, it does not care about the specific implementation of the alert dialog as long as it extends the _CustomDialog_ class and provides the _show()_ method. Also, the implementation of the dialog widget is encapsulated and defined in a separate factory method (inside the specific implementation of _CustomDialog_ class - _create()_ method). Hence, the UI logic is not tightly coupled to any specific alert dialog class which implementation details could be changed independently without affecting the implementation of the UI itself.

```
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
