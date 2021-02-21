import 'package:flutter/material.dart';

import '../file.dart';
import '../ivisitor.dart';

class AudioFile extends File {
  final String albumTitle;

  const AudioFile(String title, this.albumTitle, String fileExtension, int size)
      : super(title, fileExtension, size, Icons.music_note);

  @override
  String accept(IVisitor visitor) {
    return visitor.visitAudioFile(this);
  }
}
