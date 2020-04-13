import 'package:flutter/material.dart';

class BurgerInformationLabel extends StatelessWidget {
  final String label;

  const BurgerInformationLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context)
          .textTheme
          .subhead
          .copyWith(fontWeight: FontWeight.bold),
    );
  }
}
