import 'package:flutter/widgets.dart';

abstract interface class IFile {
  int getSize();
  Widget render(BuildContext context);
}
