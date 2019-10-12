import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_design_patterns/constants.dart';

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
            style: Theme.of(context).textTheme.body2,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
