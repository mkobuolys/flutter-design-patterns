import 'package:flutter/cupertino.dart';

import '../custom_dialog.dart';

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
