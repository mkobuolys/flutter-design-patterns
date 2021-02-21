import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/widgets/design_patterns/composite/files/file.dart';

class TextFile extends File {
  const TextFile(String title, int size)
      : super(title, size, Icons.description);
}
