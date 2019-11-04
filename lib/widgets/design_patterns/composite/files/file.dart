import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/constants.dart';
import 'package:flutter_design_patterns/design_patterns/composite/ifile.dart';
import 'package:flutter_design_patterns/helpers/file_size_converter.dart';

class File extends StatelessWidget implements IFile {
  final String title;
  final int size;
  final IconData icon;

  const File(this.title, this.size, this.icon);

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
          title,
          style: Theme.of(context).textTheme.body2,
        ),
        leading: Icon(icon),
        trailing: Text(
          FileSizeConverter.bytesToString(size),
          style:
              Theme.of(context).textTheme.body1.copyWith(color: Colors.black54),
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
