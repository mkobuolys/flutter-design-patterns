import 'package:flutter_design_patterns/design_patterns/visitor/directory.dart';
import 'package:flutter_design_patterns/design_patterns/visitor/files/index.dart';

abstract class IVisitor {
  visitDirectory(Directory directory);
  visitAudioFile(AudioFile file);
  visitImageFile(ImageFile file);
  visitTextFile(TextFile file);
  visitVideoFile(VideoFile file);
}
