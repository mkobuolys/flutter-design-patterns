import 'package:flutter/material.dart';

import '../file.dart';
import '../ivisitor.dart';

class AudioFile extends File {
  const AudioFile({
    required this.albumTitle,
    required super.title,
    required super.fileExtension,
    required super.size,
  }) : super(icon: Icons.music_note);

  final String albumTitle;

  @override
  String accept(IVisitor visitor) => visitor.visitAudioFile(this);
}
