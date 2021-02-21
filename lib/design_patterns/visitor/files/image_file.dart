import 'package:flutter/material.dart';

import '../file.dart';
import '../ivisitor.dart';

class ImageFile extends File {
  final String resolution;

  const ImageFile(String title, this.resolution, String fileExtension, int size)
      : super(title, fileExtension, size, Icons.image);

  @override
  String accept(IVisitor visitor) {
    return visitor.visitImageFile(this);
  }
}
