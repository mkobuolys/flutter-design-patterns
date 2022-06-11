import 'package:flutter/material.dart';

import 'file.dart';

class VideoFile extends File {
  const VideoFile({
    required super.title,
    required super.size,
  }) : super(icon: Icons.movie);
}
