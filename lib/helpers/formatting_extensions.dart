extension FormattingExtensions on String {
  String indentAndAddNewLine(int nTabs) => '${'\t' * nTabs}$this\n';
}
