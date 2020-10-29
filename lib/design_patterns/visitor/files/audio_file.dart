import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/design_patterns/visitor/ivisitor.dart';
import 'package:flutter_design_patterns/design_patterns/visitor/file.dart';

class AudioFile extends File {
  final String albumTitle;

  const AudioFile(String title, this.albumTitle, String fileExtension, int size)
      : super(title, fileExtension, size, Icons.music_note);

  @override
  String accept(IVisitor visitor) {
    return visitor.visitAudioFile(this);
  }
}
