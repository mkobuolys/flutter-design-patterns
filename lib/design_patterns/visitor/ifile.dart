import 'package:flutter/widgets.dart';

import 'ivisitor.dart';

abstract interface class IFile {
  int getSize();
  Widget render(BuildContext context);
  String accept(IVisitor visitor);
}
