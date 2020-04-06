import 'package:flutter/foundation.dart';

import 'package:flutter_design_patterns/design_patterns/builder/burger_builder_base.dart';

class BurgerMenuItem {
  final String label;
  final BurgerBuilderBase burgerBuilder;

  BurgerMenuItem({
    @required this.label,
    @required this.burgerBuilder,
  })  : assert(label != null),
        assert(burgerBuilder != null);
}
