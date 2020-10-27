import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/design_patterns/visitor/ivisitor.dart';
import 'package:flutter_design_patterns/design_patterns/visitor/file.dart';

class AudioFile extends File {
  AudioFile(String title, int size) : super(title, size, Icons.music_note);

  @override
  void accept(IVisitor visitor) {
    // TODO: implement accept
  }
}
