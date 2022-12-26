import 'package:flutter/services.dart' show rootBundle;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../constants/constants.dart';

part 'markdown_repository.g.dart';

@riverpod
MarkdownRepository markdownRepository(_) => const MarkdownRepository();

@riverpod
Future<String> markdown(MarkdownRef ref, String id) {
  return ref.watch(markdownRepositoryProvider).get(id);
}

class MarkdownRepository {
  const MarkdownRepository();

  Future<String> get(String designPatternId) async {
    final path = '${AssetConstants.markdownPath}$designPatternId.md';
    final markdownString = await rootBundle.loadString(path);

    return markdownString;
  }
}
