import 'package:flutter/material.dart';

import '../file.dart';
import '../ivisitor.dart';

class TextFile extends File {
  final String content;

  const TextFile(String title, this.content, String fileExtension, int size)
      : super(title, fileExtension, size, Icons.description);

  @override
  String accept(IVisitor visitor) {
    return visitor.visitTextFile(this);
  }
}
