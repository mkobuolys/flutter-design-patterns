import 'package:flutter/material.dart';

import '../file.dart';
import '../ivisitor.dart';

class TextFile extends File {
  const TextFile({
    required this.content,
    required super.title,
    required super.fileExtension,
    required super.size,
  }) : super(icon: Icons.description);

  final String content;

  @override
  String accept(IVisitor visitor) => visitor.visitTextFile(this);
}
