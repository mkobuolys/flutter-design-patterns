import 'package:meta/meta.dart';

import '../../../design_patterns/builder/burger_builder_base.dart';

class BurgerMenuItem {
  final String label;
  final BurgerBuilderBase burgerBuilder;

  BurgerMenuItem({
    @required this.label,
    @required this.burgerBuilder,
  })  : assert(label != null),
        assert(burgerBuilder != null);
}
