import 'package:flutter/material.dart';

import 'file.dart';

final class ImageFile extends File {
  const ImageFile({
    required super.title,
    required super.size,
  }) : super(icon: Icons.image);
}
