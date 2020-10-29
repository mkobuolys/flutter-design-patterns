import 'package:flutter_design_patterns/design_patterns/visitor/directory.dart';
import 'package:flutter_design_patterns/design_patterns/visitor/files/index.dart';

abstract class IVisitor {
  String visitDirectory(Directory directory);
  String visitAudioFile(AudioFile file);
  String visitImageFile(ImageFile file);
  String visitTextFile(TextFile file);
  String visitVideoFile(VideoFile file);
}
