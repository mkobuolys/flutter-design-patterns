import 'package:flutter/widgets.dart';

import 'package:flutter_design_patterns/design_patterns/visitor/ivisitor.dart';

abstract class IFile {
  int getSize();
  Widget render(BuildContext context);
  String accept(IVisitor visitor);
}
