import 'package:flutter/material.dart';

abstract class CustomDialog {
  Widget create(BuildContext context);
  Future<void> show(BuildContext context) async {
    var dialog = create(context);

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext _) {
        return dialog;
      },
    );
  }
}
