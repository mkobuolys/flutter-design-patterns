import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/constants.dart';
import '../../../../data/models/design_pattern.dart';
import '../../../../data/repositories/markdown_repository.dart';
import '../../../../themes.dart';
import 'rich_markdown_body.dart';

class MarkdownView extends ConsumerWidget {
  const MarkdownView({
    required this.designPattern,
  });

  final DesignPattern designPattern;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final markdown = ref.watch(markdownProvider(designPattern.id));

    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(LayoutConstants.paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              designPattern.description,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.justify,
              overflow: TextOverflow.ellipsis,
              maxLines: 99,
            ),
            const SizedBox(height: LayoutConstants.spaceL),
            markdown.when(
              data: (data) => RichMarkdownBody(data: data),
              loading: () => Center(
                child: CircularProgressIndicator(
                  backgroundColor: lightBackgroundColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.black.withOpacity(0.65),
                  ),
                ),
              ),
              error: (_, __) => const Text('Oops, something went wrong...'),
            ),
          ],
        ),
      ),
    );
  }
}
