import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/constants.dart';

final markdownRepositoryProvider = Provider(
  (ref) => const MarkdownRepository(),
);

final markdownProvider = FutureProvider.autoDispose.family<String, String>(
  (ref, id) => ref.watch(markdownRepositoryProvider).get(id),
);

class MarkdownRepository {
  const MarkdownRepository();

  Future<String> get(String designPatternId) async {
    final path = '${AssetConstants.markdownPath}$designPatternId.md';
    final markdownString = await rootBundle.loadString(path);

    return markdownString;
  }
}
