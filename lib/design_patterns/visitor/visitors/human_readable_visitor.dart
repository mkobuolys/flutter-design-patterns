import 'package:flutter_design_patterns/design_patterns/visitor/directory.dart';
import 'package:flutter_design_patterns/design_patterns/visitor/files/index.dart';
import 'package:flutter_design_patterns/design_patterns/visitor/ivisitor.dart';
import 'package:flutter_design_patterns/helpers/index.dart';

class HumanReadableVisitor implements IVisitor {
  @override
  String getTitle() => 'Export as text';

  @override
  String visitAudioFile(AudioFile file) {
    return '${file.title}:'.indentAndAddNewLine(0) +
        'Type: Audio'.indentAndAddNewLine(2) +
        'Album: ${file.albumTitle}'.indentAndAddNewLine(2) +
        'Extension: ${file.fileExtension}'.indentAndAddNewLine(2) +
        'Size: ${FileSizeConverter.bytesToString(file.getSize())}'
            .indentAndAddNewLine(2);
  }

  @override
  String visitDirectory(Directory directory) {
    String directoryText = "";

    for (var file in directory.files) {
      directoryText += "${file.accept(this)}";
    }

    return directoryText;
  }

  @override
  String visitImageFile(ImageFile file) {
    return '${file.title}:'.indentAndAddNewLine(0) +
        'Type: Image'.indentAndAddNewLine(2) +
        'Resolution: ${file.resolution}'.indentAndAddNewLine(2) +
        'Extension: ${file.fileExtension}'.indentAndAddNewLine(2) +
        'Size: ${FileSizeConverter.bytesToString(file.getSize())}'
            .indentAndAddNewLine(2);
  }

  @override
  String visitTextFile(TextFile file) {
    String fileContentPreview = file.content.length > 30
        ? '${file.content.substring(0, 30)}...'
        : file.content;

    return '${file.title}:'.indentAndAddNewLine(0) +
        'Type: Text'.indentAndAddNewLine(2) +
        'Preview: $fileContentPreview'.indentAndAddNewLine(2) +
        'Extension: ${file.fileExtension}'.indentAndAddNewLine(2) +
        'Size: ${FileSizeConverter.bytesToString(file.getSize())}'
            .indentAndAddNewLine(2);
  }

  @override
  String visitVideoFile(VideoFile file) {
    return '${file.title}:'.indentAndAddNewLine(0) +
        'Type: Video'.indentAndAddNewLine(2) +
        'Directed by: ${file.directedBy}'.indentAndAddNewLine(2) +
        'Extension: ${file.fileExtension}'.indentAndAddNewLine(2) +
        'Size: ${FileSizeConverter.bytesToString(file.getSize())}'
            .indentAndAddNewLine(2);
  }
}
