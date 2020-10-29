import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/design_patterns/visitor/ivisitor.dart';
import 'package:flutter_design_patterns/design_patterns/visitor/file.dart';

class VideoFile extends File {
  final String directedBy;

  const VideoFile(String title, this.directedBy, String fileExtension, int size)
      : super(title, fileExtension, size, Icons.movie);

  @override
  String accept(IVisitor visitor) {
    return visitor.visitVideoFile(this);
  }
}
