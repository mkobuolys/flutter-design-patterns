import 'package:flutter/material.dart';

import 'file.dart';

class TextFile extends File {
  const TextFile(String title, int size)
      : super(title, size, Icons.description);
}
