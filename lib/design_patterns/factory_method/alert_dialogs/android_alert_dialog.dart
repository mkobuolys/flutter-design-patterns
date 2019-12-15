import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/design_patterns/factory_method/custom_dialog.dart';

class AndroidAlertDialog extends CustomDialog {
  @override
  Widget create(BuildContext context) {
    return AlertDialog(
      title: Text('Android Alert Dialog'),
      content: Text('This is the material-style alert dialog!'),
      actions: <Widget>[
        FlatButton(
          child: Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
