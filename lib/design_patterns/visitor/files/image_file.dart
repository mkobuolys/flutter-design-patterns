import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/design_patterns/visitor/ivisitor.dart';
import 'package:flutter_design_patterns/design_patterns/visitor/file.dart';

class ImageFile extends File {
  final String resolution;

  const ImageFile(String title, this.resolution, String fileExtension, int size)
      : super(title, fileExtension, size, Icons.image);

  @override
  String accept(IVisitor visitor) {
    return visitor.visitImageFile(this);
  }
}
