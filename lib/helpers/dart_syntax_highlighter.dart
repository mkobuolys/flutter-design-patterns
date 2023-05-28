import 'package:flutter/material.dart'
    show BuildContext, Color, TextSpan, TextStyle, Theme;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:highlight/highlight.dart';

class DartSyntaxHighlighter extends SyntaxHighlighter {
  DartSyntaxHighlighter(this.context);

  final String _rootKey = 'root';
  final BuildContext context;

  @override
  TextSpan format(String source) {
    return TextSpan(
      style: _syntaxTheme[_rootKey],
      children: _convert(
        highlight.parse(source, language: 'dart').nodes!,
      ),
    );
  }

  List<TextSpan> _convert(List<Node> nodes) {
    List<TextSpan> currentSpans = [];
    final List<List<TextSpan>> stack = [];

    void traverse(Node node) {
      if (node.value != null) {
        currentSpans.add(
          node.className == null
              ? TextSpan(text: node.value)
              : TextSpan(text: node.value, style: _syntaxTheme[node.className]),
        );
      } else if (node.children != null) {
        final List<TextSpan> tmp = [];

        currentSpans.add(
          TextSpan(
            children: tmp,
            style: _syntaxTheme[node.className],
          ),
        );

        stack.add(currentSpans);
        currentSpans = tmp;

        node.children?.forEach((n) {
          traverse(n);

          if (n == node.children?.last) {
            currentSpans = stack.isEmpty ? currentSpans : stack.removeLast();
          }
        });
      }
    }

    for (final node in nodes) {
      traverse(node);
    }

    return currentSpans;
  }

  Map<String, TextStyle?> get _syntaxTheme {
    final textStyle = Theme.of(context).textTheme.bodyMedium;

    const magenta = Color.fromRGBO(191, 58, 91, 1.0);
    const peach = Color.fromRGBO(206, 138, 116, 1.0);
    const purple = Color.fromRGBO(156, 109, 217, 1.0);
    const lightBlue = Color.fromRGBO(76, 166, 230, 1.0);
    const oceanBlue = Color.fromRGBO(64, 103, 230, 1.0);
    const green = Color.fromRGBO(95, 174, 122, 1.0);
    const grey = Color.fromRGBO(155, 155, 155, 1.0);
    const darkerGrey = Color.fromRGBO(130, 130, 130, 1.0);

    return {
      'argument': textStyle?.copyWith(color: grey),
      'built_in': textStyle?.copyWith(color: purple),
      'doctag': textStyle?.copyWith(color: darkerGrey),
      'class': textStyle?.copyWith(color: oceanBlue),
      'comment': textStyle?.copyWith(color: darkerGrey),
      'constant': textStyle?.copyWith(color: peach),
      'enum': textStyle?.copyWith(color: oceanBlue),
      'enumConstant': textStyle?.copyWith(color: oceanBlue),
      'function': textStyle?.copyWith(color: magenta),
      'keyword': textStyle?.copyWith(color: magenta),
      'main': textStyle?.copyWith(color: oceanBlue),
      'meta': textStyle?.copyWith(color: magenta),
      'number': textStyle?.copyWith(color: lightBlue),
      'operator': textStyle?.copyWith(color: magenta),
      'parameter': textStyle?.copyWith(color: grey),
      'property': textStyle,
      'punctuation': textStyle?.copyWith(color: magenta),
      'root': textStyle,
      'string': textStyle?.copyWith(color: green),
      'subst': textStyle?.copyWith(color: oceanBlue),
      'type': textStyle?.copyWith(color: oceanBlue),
      'variable': textStyle?.copyWith(color: grey),
    };
  }
}
