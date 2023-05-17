import 'package:flutter/material.dart';

import '../../platform_specific/platform_button.dart';

class FilesDialog extends StatelessWidget {
  const FilesDialog({
    required this.filesText,
  });

  final String filesText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Files'),
      content: ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(filesText),
          ),
        ),
      ),
      actions: <Widget>[
        PlatformButton(
          materialColor: Colors.black,
          materialTextColor: Colors.white,
          onPressed: Navigator.of(context).pop,
          text: 'Close',
        ),
      ],
    );
  }
}
