import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../helpers/dart_sytax_highlighter.dart';
import '../../../helpers/url_launcher.dart';

class RichMarkdownBody extends StatelessWidget {
  const RichMarkdownBody({this.data, super.key});

  final String? data;

  String parseSyntaxLanguage(String data) {
    String parsed = data;
    final RegExp codeSign = RegExp('`{3} *');
    final RegExp pattern = RegExp(r'`{3} *\w+');
    for (final RegExpMatch match in pattern.allMatches(data)) {
      final String? lang = match.group(0)?.split(codeSign)[1];
      parsed = parsed.replaceFirst(match.group(0).toString(), '```$lang');
      log('lang: $lang');
    }
    return parsed;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textTheme = theme.textTheme;
    final bodyMedium = textTheme.bodyMedium;
    final fontSize = theme.textTheme.bodyMedium?.fontSize ?? 14.0;

    return MarkdownBody(
      selectable: true,
      fitContent: false,
      styleSheet: MarkdownStyleSheet(
        h1: textTheme.headlineMedium,
        h2: textTheme.titleLarge,
        h3: textTheme.titleMedium,
        h4: textTheme.titleMedium,
        h5: textTheme.titleMedium,
        h6: textTheme.titleLarge,
        p: bodyMedium,
        blockSpacing: 8,
        blockquotePadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        horizontalRuleDecoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: theme.colorScheme.primary.withOpacity(0.2),
              width: 3,
            ),
          ),
        ),
        blockquoteDecoration: BoxDecoration(
          color: theme.colorScheme.surface.withOpacity(0.2),
          border: Border(
            left: BorderSide(
              color: theme.colorScheme.surface,
              width: 3,
            ),
          ),
        ),
        codeblockDecoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: theme.colorScheme.outline.withOpacity(0.2),
          ),
        ),
        a: bodyMedium?.copyWith(
          color: theme.colorScheme.primary,
          decoration: TextDecoration.underline,
        ),
        blockquote: bodyMedium?.copyWith(
          color: theme.colorScheme.onSurface.withOpacity(0.6),
        ),
        code: bodyMedium?.copyWith(
          color: theme.colorScheme.primary.withOpacity(1.0),
        ),
        em: bodyMedium?.copyWith(fontStyle: FontStyle.italic),
        strong: bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        img: bodyMedium,
        listBullet: bodyMedium?.copyWith(
          color: textTheme.bodySmall?.color,
        ),
        listBulletPadding: const EdgeInsets.symmetric(horizontal: 2),
        tableBody: bodyMedium?.copyWith(
          color: textTheme.bodyMedium?.color?.withOpacity(0.8),
        ),
        tableHead: bodyMedium?.copyWith(
          fontSize: fontSize + 2,
          color: textTheme.bodyLarge?.color,
        ),
        tableHeadAlign: TextAlign.center,
        tableCellsPadding: const EdgeInsets.all(8),
        tableBorder: TableBorder.all(
          color: theme.colorScheme.onSurface.withOpacity(0.6),
        ),
      ),
      onTapLink: (_, link, __) => UrlLauncher.launchUrl(link ?? ''),
      syntaxHighlighter: DartSyntaxHighlighter(context),
      data: data ??'',
    );
  }
}
