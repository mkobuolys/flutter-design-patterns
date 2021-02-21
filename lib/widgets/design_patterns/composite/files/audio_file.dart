import 'package:flutter/material.dart';

import 'file.dart';

class AudioFile extends File {
  const AudioFile(String title, int size)
      : super(title, size, Icons.music_note);
}
