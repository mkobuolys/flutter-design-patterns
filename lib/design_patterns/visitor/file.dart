import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/constants.dart';
import 'package:flutter_design_patterns/design_patterns/visitor/ifile.dart';
import 'package:flutter_design_patterns/helpers/file_size_converter.dart';

abstract class File extends StatelessWidget implements IFile {
  final String title;
  final String fileExtension;
  final int size;
  final IconData icon;

  const File(this.title, this.fileExtension, this.size, this.icon);

  @override
  int getSize() {
    return size;
  }

  @override
  Widget render(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: paddingS),
      child: ListTile(
        title: Text(
          '$title.$fileExtension',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        leading: Icon(icon),
        trailing: Text(
          FileSizeConverter.bytesToString(size),
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(color: Colors.black54),
        ),
        dense: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return render(context);
  }
}
