import 'package:flutter_design_patterns/design_patterns/visitor/directory.dart';
import 'package:flutter_design_patterns/design_patterns/visitor/files/index.dart';
import 'package:flutter_design_patterns/design_patterns/visitor/ivisitor.dart';

class HumanReadableVisitor implements IVisitor {
  @override
  String visitAudioFile(AudioFile file) {
    // TODO: implement visitAudioFile
    throw UnimplementedError();
  }

  @override
  String visitDirectory(Directory directory) {
    // TODO: implement visitDirectory
    throw UnimplementedError();
  }

  @override
  String visitImageFile(ImageFile file) {
    // TODO: implement visitImageFile
    throw UnimplementedError();
  }

  @override
  String visitTextFile(TextFile file) {
    // TODO: implement visitTextFile
    throw UnimplementedError();
  }

  @override
  String visitVideoFile(VideoFile file) {
    // TODO: implement visitVideoFile
    throw UnimplementedError();
  }
}
