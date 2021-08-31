import 'package:flutter/widgets.dart';

import '../../../../constants/constants.dart';

class ExampleView extends StatelessWidget {
  final Widget example;

  const ExampleView({
    required this.example,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(LayoutConstants.paddingL),
      child: example,
    );
  }
}
