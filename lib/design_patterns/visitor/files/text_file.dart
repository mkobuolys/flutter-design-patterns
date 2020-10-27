import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/design_patterns/visitor/ivisitor.dart';
import 'package:flutter_design_patterns/design_patterns/visitor/file.dart';

class TextFile extends File {
  TextFile(String title, int size) : super(title, size, Icons.description);

  @override
  void accept(IVisitor visitor) {
    // TODO: implement accept
  }
}
