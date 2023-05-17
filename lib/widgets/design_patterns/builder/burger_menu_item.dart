import '../../../design_patterns/builder/builder.dart';

class BurgerMenuItem {
  const BurgerMenuItem({
    required this.label,
    required this.burgerBuilder,
  });

  final String label;
  final BurgerBuilderBase burgerBuilder;
}
