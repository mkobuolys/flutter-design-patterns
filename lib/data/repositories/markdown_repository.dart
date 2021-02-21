import 'package:flutter/services.dart' show rootBundle;

import '../../constants.dart';

class MarkdownRepository {
  Future<String> get(String designPatternId) async {
    final path = '$markdownPath$designPatternId.md';
    final markdownString = await rootBundle.loadString(path);

    return markdownString;
  }
}
