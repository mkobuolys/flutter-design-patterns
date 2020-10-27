import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/design_patterns/visitor/ivisitor.dart';
import 'package:flutter_design_patterns/design_patterns/visitor/file.dart';

class VideoFile extends File {
  VideoFile(String title, int size) : super(title, size, Icons.movie);

  @override
  void accept(IVisitor visitor) {
    // TODO: implement accept
  }
}
