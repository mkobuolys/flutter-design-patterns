import 'package:flutter/widgets.dart';

abstract class IFile {
  int getSize();
  Widget render(BuildContext context);
}
