import 'package:flutter/material.dart';

import 'file.dart';

class AudioFile extends File {
  const AudioFile({
    required super.title,
    required super.size,
  }) : super(icon: Icons.music_note);
}
