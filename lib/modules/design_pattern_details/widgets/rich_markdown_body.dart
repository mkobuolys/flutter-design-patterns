import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:highlight/highlight.dart';

import '../../../helpers/url_launcher.dart';

class RichMarkdownBody extends StatefulWidget {
  const RichMarkdownBody({
    super.key,
    this.data,
    this.textStyle,
  });

  final String? data;
  final TextStyle? textStyle;

  @override
  State<RichMarkdownBody> createState() => _RichMarkdownBodyState();
}

class _RichMarkdownBodyState extends State<RichMarkdownBody>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);

    final textTheme = theme.textTheme;
    final bodyMedium = textTheme.bodyMedium;
    final fontSize = widget.textStyle?.fontSize ?? 16.0;

    try {
      return MarkdownBody(
        selectable: true,
        fitContent: false,
        styleSheet: MarkdownStyleSheet(
          h1: textTheme.displayLarge?.copyWith(
            fontSize: 50,
          ),
          h2: textTheme.displayMedium?.copyWith(
            fontSize: 35,
          ),
          h3: textTheme.displaySmall?.copyWith(
            fontSize: 30,
          ),
          h4: textTheme.headlineMedium?.copyWith(
            fontSize: 24,
          ),
          h5: textTheme.headlineSmall?.copyWith(
            fontSize: 20,
          ),
          h6: textTheme.titleLarge?.copyWith(
            fontSize: 18,
          ),
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
            color: theme.colorScheme.primary.withOpacity(0.2),
            border: Border(
              left: BorderSide(
                color: theme.colorScheme.primary,
                width: 3,
              ),
            ),
          ),
          codeblockDecoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 1.0),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color.fromRGBO(55, 85, 124, 1.0),
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
            fontSize: fontSize - 1,
            color: theme.colorScheme.primary,
          ),
          em: bodyMedium?.copyWith(
            fontStyle: FontStyle.italic,
          ),
          strong: bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          img: bodyMedium,
          listBullet: bodyMedium?.copyWith(
            color: textTheme.bodySmall?.color,
          ),
          listBulletPadding: const EdgeInsets.symmetric(horizontal: 2),
          tableBody: bodyMedium?.copyWith(
            fontSize: fontSize - 1,
            color: textTheme.bodyMedium?.color?.withOpacity(0.8),
          ),
          tableHead: bodyMedium?.copyWith(
            fontSize: fontSize + 1,
            color: textTheme.bodyLarge?.color,
          ),
          tableHeadAlign: TextAlign.center,
          tableCellsPadding: const EdgeInsets.all(8),
          tableBorder: TableBorder.all(
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        onTapLink: (_, link, __) => UrlLauncher.launchUrl(link ?? ''),
        syntaxHighlighter: LangSyntaxHighlighter(
          _syntaxTheme(theme),
          'dart',
        ),
        data: parseSyntaxLanguage(widget.data ?? '-'),
      );
    } catch (e) {
      return const Text('Unable to display markdown');
    }
  }
}

String parseSyntaxLanguage(String data) {
  String parsed = data;
  final RegExp codeSign = RegExp(r'`{3} *');
  final RegExp pattern = RegExp(r'`{3} *\w+');
  for (final RegExpMatch match in pattern.allMatches(data)) {
    final String? lang = match.group(0)?.split(codeSign)[1];
    parsed = parsed.replaceFirst(match.group(0).toString(), '```\n$lang');
    log('lang: $lang');
  } // CAUTION "\n" newline is required
  return parsed;
}

class LangSyntaxHighlighter extends SyntaxHighlighter {
  LangSyntaxHighlighter(this.theme, this.language);

  final String language;
  final String _rootKey = 'root';
  final Map<String, TextStyle?> theme;

  @override
  TextSpan format(String source) {
    final String lang = source.split('\n').first;

    return TextSpan(
      style: theme[_rootKey],
      children: _convert(
        highlight.parse(source, language: lang).nodes!,
      ),
    );
  }

  List<TextSpan> _convert(List<Node> nodes) {
    final List<TextSpan> spans = [];
    var currentSpans = spans;
    final List<List<TextSpan>> stack = [];

    void traverse(Node node) {
      if (node.value != null) {
        currentSpans.add(
          node.className == null
              ? TextSpan(text: node.value)
              : TextSpan(text: node.value, style: theme[node.className]),
        );
      } else if (node.children != null) {
        final List<TextSpan> tmp = [];
        currentSpans.add(TextSpan(children: tmp, style: theme[node.className]));
        stack.add(currentSpans);
        currentSpans = tmp;

        node.children?.forEach((n) {
          traverse(n);
          if (n == node.children?.last) {
            currentSpans = stack.isEmpty ? spans : stack.removeLast();
          }
        });
      }
    }

    for (final node in nodes) {
      traverse(node);
    }
    return spans;
  }
}

Map<String, TextStyle?> _syntaxTheme(ThemeData theme) {
  final textStyle = theme.textTheme.bodyMedium?.copyWith(
    color: const Color.fromRGBO(0, 0, 0, 1.0),
  );
  return {
    'root': textStyle,
    'keyword': textStyle?.copyWith(
      color: const Color.fromRGBO(191, 58, 91, 1.0),
    ),
    'subst': textStyle?.copyWith(
      color: const Color.fromRGBO(64, 103, 230, 1.0),
    ),
    'built_in': textStyle?.copyWith(
      color: const Color.fromRGBO(156, 109, 217, 1.0),
    ),
    'number': textStyle?.copyWith(
      color: const Color.fromRGBO(76, 166, 230, 1.0),
    ),
    'string': textStyle?.copyWith(
      color: const Color.fromRGBO(95, 174, 122, 1.0),
    ),
    'punctuation': textStyle?.copyWith(
      color: const Color.fromRGBO(255, 255, 255, 0.5),
    ),
    'class': textStyle?.copyWith(
      color: const Color.fromRGBO(64, 103, 230, 1.0),
    ),
    'constant': textStyle?.copyWith(
      color: const Color.fromRGBO(206, 138, 116, 1.0),
    ),
    'operator': textStyle?.copyWith(
      color: const Color.fromRGBO(191, 58, 91, 1.0),
    ),
    'main': textStyle?.copyWith(
      color: const Color.fromRGBO(64, 103, 230, 1.0),
    ),
    'function': textStyle?.copyWith(
      color: const Color.fromRGBO(191, 58, 91, 1.0),
    ),
    'property': textStyle,
    'parameter': textStyle?.copyWith(
      color: const Color.fromRGBO(155, 155, 155, 1.0),
    ),
    'argument': textStyle?.copyWith(
      color: const Color.fromRGBO(155, 155, 155, 1.0),
    ),
    'variable': textStyle?.copyWith(
      color: const Color.fromRGBO(155, 155, 155, 1.0),
    ),
    'type': textStyle?.copyWith(
      color: const Color.fromRGBO(64, 103, 230, 1.0),
    ),
    'enum': textStyle?.copyWith(
      color: const Color.fromRGBO(64, 103, 230, 1.0),
    ),
    'enumConstant': textStyle?.copyWith(
      color: const Color.fromRGBO(64, 103, 230, 1.0),
    ),
    'meta': textStyle?.copyWith(
      color: const Color.fromRGBO(191, 58, 91, 1.0),
    ),
    'comment': textStyle?.copyWith(
      fontWeight: FontWeight.w400,
      color: const Color.fromRGBO(130, 130, 130, 1.0),
    ),
    'doctag': textStyle?.copyWith(
      color: const Color.fromRGBO(130, 130, 130, 1.0),
    ),
  };
}
