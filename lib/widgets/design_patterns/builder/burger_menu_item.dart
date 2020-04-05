import 'package:flutter/foundation.dart';

class BurgerMenuItem {
  final String label;
  final Function prepareBurger;

  BurgerMenuItem({
    @required this.label,
    @required this.prepareBurger,
  })  : assert(label != null),
        assert(prepareBurger != null);
}
