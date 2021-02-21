import 'package:flutter/widgets.dart';

import 'ivisitor.dart';

abstract class IFile {
  int getSize();
  Widget render(BuildContext context);
  String accept(IVisitor visitor);
}
