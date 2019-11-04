import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/widgets/design_patterns/composite/files/file.dart';

class ImageFile extends File {
  ImageFile(String title, int size) : super(title, size, Icons.image);
}
