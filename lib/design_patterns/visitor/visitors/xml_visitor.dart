import 'package:flutter_design_patterns/design_patterns/visitor/directory.dart';
import 'package:flutter_design_patterns/design_patterns/visitor/files/index.dart';
import 'package:flutter_design_patterns/design_patterns/visitor/ivisitor.dart';
import 'package:flutter_design_patterns/helpers/index.dart';

class XmlVisitor implements IVisitor {
  @override
  String getTitle() => 'Export as XML';

  @override
  String visitAudioFile(AudioFile file) {
    return '<audio>'.indentAndAddNewLine(1) +
        '<title>${file.title}</title>'.indentAndAddNewLine(2) +
        '<album>${file.albumTitle}</album>'.indentAndAddNewLine(2) +
        '<extension>${file.fileExtension}</extension>'.indentAndAddNewLine(2) +
        '<size>${FileSizeConverter.bytesToString(file.getSize())}</size>'
            .indentAndAddNewLine(2) +
        '</audio>'.indentAndAddNewLine(1);
  }

  @override
  String visitDirectory(Directory directory) {
    bool isRootDirectory = directory.level == 0;

    String directoryText = isRootDirectory ? '<files>\n' : '';

    for (var file in directory.files) {
      directoryText += "${file.accept(this)}";
    }

    return isRootDirectory ? '$directoryText</files>\n' : directoryText;
  }

  @override
  String visitImageFile(ImageFile file) {
    return '<image>'.indentAndAddNewLine(1) +
        '<title>${file.title}</title>'.indentAndAddNewLine(2) +
        '<resolution>${file.resolution}</resolution>'.indentAndAddNewLine(2) +
        '<extension>${file.fileExtension}</extension>'.indentAndAddNewLine(2) +
        '<size>${FileSizeConverter.bytesToString(file.getSize())}</size>'
            .indentAndAddNewLine(2) +
        '</image>'.indentAndAddNewLine(1);
  }

  @override
  String visitTextFile(TextFile file) {
    String fileContentPreview = file.content.length > 30
        ? '${file.content.substring(0, 30)}...'
        : file.content;

    return '<text>'.indentAndAddNewLine(1) +
        '<title>${file.title}</title>'.indentAndAddNewLine(2) +
        '<preview>$fileContentPreview</preview>'.indentAndAddNewLine(2) +
        '<extension>${file.fileExtension}</extension>'.indentAndAddNewLine(2) +
        '<size>${FileSizeConverter.bytesToString(file.getSize())}</size>'
            .indentAndAddNewLine(2) +
        '</text>'.indentAndAddNewLine(1);
  }

  @override
  String visitVideoFile(VideoFile file) {
    return '<video>'.indentAndAddNewLine(1) +
        '<title>${file.title}</title>'.indentAndAddNewLine(2) +
        '<directed_by>${file.directedBy}</directed_by>'.indentAndAddNewLine(2) +
        '<extension>${file.fileExtension}</extension>'.indentAndAddNewLine(2) +
        '<size>${FileSizeConverter.bytesToString(file.getSize())}</size>'
            .indentAndAddNewLine(2) +
        '</video>'.indentAndAddNewLine(1);
  }
}
