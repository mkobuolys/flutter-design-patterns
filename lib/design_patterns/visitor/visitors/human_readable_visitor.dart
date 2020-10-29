import 'package:flutter_design_patterns/design_patterns/visitor/directory.dart';
import 'package:flutter_design_patterns/design_patterns/visitor/files/index.dart';
import 'package:flutter_design_patterns/design_patterns/visitor/ivisitor.dart';
import 'package:flutter_design_patterns/helpers/file_size_converter.dart';

class HumanReadableVisitor implements IVisitor {
  @override
  String visitAudioFile(AudioFile file) {
    return "${file.title}:\n" +
        "\tType: Audio\n" +
        "\tAlbum: ${file.albumTitle}\n" +
        "\tExtension: ${file.fileExtension}\n" +
        "\tSize: ${FileSizeConverter.bytesToString(file.getSize())}\n";
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
    return "${file.title}:\n" +
        "\tType: Image\n" +
        "\tResolution: ${file.resolution}px\n" +
        "\tExtension: ${file.fileExtension}\n" +
        "\tSize: ${FileSizeConverter.bytesToString(file.getSize())}\n";
  }

  @override
  String visitTextFile(TextFile file) {
    return "${file.title}:\n" +
        "\tType: Text\n" +
        "\tPreview: ${file.content.substring(0, 30)}...\n" +
        "\tExtension: ${file.fileExtension}\n" +
        "\tSize: ${FileSizeConverter.bytesToString(file.getSize())}\n";
  }

  @override
  String visitVideoFile(VideoFile file) {
    return "${file.title}:\n" +
        "\tType: Video\n" +
        "\tDirected by: ${file.directedBy}\n" +
        "\tExtension: ${file.fileExtension}\n" +
        "\tSize: ${FileSizeConverter.bytesToString(file.getSize())}\n";
  }
}
