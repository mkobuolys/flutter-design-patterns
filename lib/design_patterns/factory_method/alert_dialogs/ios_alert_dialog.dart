import 'package:flutter/cupertino.dart';

import 'package:flutter_design_patterns/design_patterns/factory_method/custom_dialog.dart';

class IosAlertDialog extends CustomDialog {
  @override
  Widget create(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('iOS Alert Dialog'),
      content: Text('This is the cupertino-style alert dialog!'),
      actions: <Widget>[
        CupertinoButton(
          child: Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
