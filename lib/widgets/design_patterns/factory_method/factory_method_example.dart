import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../design_patterns/factory_method/alert_dialogs/android_alert_dialog.dart';
import '../../../design_patterns/factory_method/alert_dialogs/ios_alert_dialog.dart';
import '../../../design_patterns/factory_method/custom_dialog.dart';
import '../../platform_specific/platform_button.dart';
import 'dialog_selection.dart';

class FactoryMethodExample extends StatefulWidget {
  @override
  _FactoryMethodExampleState createState() => _FactoryMethodExampleState();
}

class _FactoryMethodExampleState extends State<FactoryMethodExample> {
  final List<CustomDialog> customDialogList = [
    AndroidAlertDialog(),
    IosAlertDialog(),
  ];

  int _selectedDialogIndex = 0;

  Future _showCustomDialog(BuildContext context) async {
    final selectedDialog = customDialogList[_selectedDialogIndex];

    await selectedDialog.show(context);
  }

  void _setSelectedDialogIndex(int index) {
    setState(() {
      _selectedDialogIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: paddingL),
        child: Column(
          children: <Widget>[
            DialogSelection(
              customDialogList: customDialogList,
              selectedIndex: _selectedDialogIndex,
              onChanged: _setSelectedDialogIndex,
            ),
            const SizedBox(height: spaceL),
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
