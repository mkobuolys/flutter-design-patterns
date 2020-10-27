import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/constants.dart';
import 'package:flutter_design_patterns/design_patterns/visitor/ifile.dart';
import 'package:flutter_design_patterns/design_patterns/visitor/ivisitor.dart';
import 'package:flutter_design_patterns/helpers/file_size_converter.dart';

class Directory extends StatelessWidget implements IFile {
  final String title;
  final bool isInitiallyExpanded;

  final List<IFile> files = List<IFile>();

  Directory(this.title, {this.isInitiallyExpanded = false});

  void addFile(IFile file) {
    files.add(file);
  }

  @override
  int getSize() {
    var sum = 0;
    files.forEach((IFile file) => sum += file.getSize());
    return sum;
  }

  @override
  Widget render(BuildContext context) {
    return Theme(
      data: ThemeData(
        accentColor: Colors.black,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: paddingS),
        child: ExpansionTile(
          leading: Icon(Icons.folder),
          title: Text("$title (${FileSizeConverter.bytesToString(getSize())})"),
          children: files.map((IFile file) => file.render(context)).toList(),
          initiallyExpanded: isInitiallyExpanded,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return render(context);
  }

  @override
  void accept(IVisitor visitor) {
    // TODO: implement accept
  }
}
