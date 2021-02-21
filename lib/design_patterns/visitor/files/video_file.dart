import 'package:flutter/material.dart';

import '../file.dart';
import '../ivisitor.dart';

class VideoFile extends File {
  final String directedBy;

  const VideoFile(String title, this.directedBy, String fileExtension, int size)
      : super(title, fileExtension, size, Icons.movie);

  @override
  String accept(IVisitor visitor) {
    return visitor.visitVideoFile(this);
  }
}
