import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/constants.dart';
import 'package:flutter_design_patterns/design_patterns/visitor/directory.dart';
import 'package:flutter_design_patterns/design_patterns/visitor/files/index.dart';
import 'package:flutter_design_patterns/design_patterns/visitor/ifile.dart';

class VisitorExample extends StatefulWidget {
  @override
  _VisitorExampleState createState() => _VisitorExampleState();
}

class _VisitorExampleState extends State<VisitorExample> {
  IFile rootDirectory;

  @override
  void initState() {
    super.initState();

    rootDirectory = _buildMediaDirectory();
  }

  IFile _buildMediaDirectory() {
    var musicDirectory = Directory('Music');
    musicDirectory.addFile(
        AudioFile('Before the Storm', 'Darude - Sandstorm', 'mp3', 2612453));
    musicDirectory
        .addFile(AudioFile('Toto IV', 'Toto - Africa', 'mp3', 3219811));
    musicDirectory.addFile(AudioFile(
        'Bag Raiders', 'Bag Raiders - Shooting Stars', 'mp3', 3811214));

    var moviesDirectory = Directory('Movies');
    moviesDirectory
        .addFile(VideoFile('The Matrix', 'The Wachowskis', 'avi', 951495532));
    moviesDirectory.addFile(
        VideoFile('Pulp Fiction', 'Quentin Tarantino', 'mp4', 1251495532));

    var catPicturesDirectory = Directory('Cats');
    catPicturesDirectory.addFile(ImageFile('Cat 1', '640x480', 'jpg', 844497));
    catPicturesDirectory.addFile(ImageFile('Cat 2', '1280x720', 'jpg', 975363));
    catPicturesDirectory
        .addFile(ImageFile('Cat 3', '1920x1080', 'png', 1975363));

    var picturesDirectory = Directory('Pictures');
    picturesDirectory.addFile(catPicturesDirectory);
    picturesDirectory
        .addFile(ImageFile('Not a cat', '2560x1440', 'png', 2971361));

    var mediaDirectory = Directory('Media', isInitiallyExpanded: true);
    mediaDirectory.addFile(musicDirectory);
    mediaDirectory.addFile(moviesDirectory);
    mediaDirectory.addFile(picturesDirectory);
    mediaDirectory.addFile(Directory('New Folder'));
    mediaDirectory.addFile(TextFile('Nothing suspicious there', 'txt', 430791));
    mediaDirectory.addFile(TextFile('TeamTrees', 'txt', 1042));

    return mediaDirectory;
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: paddingL),
        child: rootDirectory.render(context),
      ),
    );
  }
}
