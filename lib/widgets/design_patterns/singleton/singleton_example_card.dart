import 'package:flutter/material.dart';

import '../../../constants.dart';

class SingletonExampleCard extends StatelessWidget {
  final String text;

  const SingletonExampleCard({
    @required this.text,
  }) : assert(text != null);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 64.0,
        padding: const EdgeInsets.all(paddingL),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
