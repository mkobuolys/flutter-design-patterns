import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/widgets/design_patterns/composite/files/file_base.dart';

class ImageFile extends FileBase {
  ImageFile(String title, int size) : super(title, size, Icons.image);
}
