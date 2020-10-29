import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/design_patterns/visitor/ivisitor.dart';
import 'package:flutter_design_patterns/design_patterns/visitor/file.dart';

class TextFile extends File {
  const TextFile(String title, String fileExtension, int size)
      : super(title, fileExtension, size, Icons.description);

  @override
  String accept(IVisitor visitor) {
    return visitor.visitTextFile(this);
  }
}
