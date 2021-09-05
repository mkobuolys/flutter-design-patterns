import 'package:flutter/widgets.dart';

import '../../../../constants/constants.dart';
import '../../../widgets/design_patterns/design_patterns_factory.dart';

class ExampleView extends StatelessWidget {
  final String designPatternId;

  const ExampleView({
    required this.designPatternId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(LayoutConstants.paddingL),
      child: DesignPatternsFactory.create(designPatternId),
    );
  }
}
