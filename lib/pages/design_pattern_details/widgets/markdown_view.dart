import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/constants.dart';
import '../../../data/models/design_pattern.dart';
import '../../../data/repositories/markdown_repository.dart';
import '../../../themes.dart';

class MarkdownView extends StatelessWidget {
  final DesignPattern designPattern;

  const MarkdownView({
    required this.designPattern,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(LayoutConstants.paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              designPattern.description,
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.justify,
              overflow: TextOverflow.ellipsis,
              maxLines: 99,
            ),
            const SizedBox(height: LayoutConstants.spaceL),
            Consumer(
              builder: (context, watch, child) {
                final repository = watch(markdownRepositoryProvider);

                return FutureBuilder<String>(
                  future: repository.get(designPattern.id),
                  initialData: '',
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return MarkdownBody(
                        data: snapshot.data!,
                        fitContent: false,
                        selectable: true,
                      );
                    }

                    return CircularProgressIndicator(
                      backgroundColor: lightBackgroundColor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.black.withOpacity(0.65),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
