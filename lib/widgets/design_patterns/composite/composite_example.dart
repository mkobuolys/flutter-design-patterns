import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/constants.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/composite/directory.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/composite/files/audio_file.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/composite/files/image_file.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/composite/files/text_file.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/composite/files/video_file.dart';

class CompositeExample extends StatelessWidget {
  Directory buildMediaDirectory() {
    var musicDirectory = Directory('Music');
    musicDirectory.addFile(AudioFile('Darude - Sandstorm.mp3', 2612453));
    musicDirectory.addFile(AudioFile('Toto - Africa.mp3', 3219811));
    musicDirectory
        .addFile(AudioFile('Bag Raiders - Shooting Stars.mp3', 3811214));

    var moviesDirectory = Directory('Movies');

    moviesDirectory.addFile(VideoFile('The Matrix.avi', 951495532));
    moviesDirectory.addFile(VideoFile('The Matrix Reloaded.mp4', 1251495532));

    var catPicturesDirectory = Directory('Cats');
    catPicturesDirectory.addFile(ImageFile('Cat 1.jpg', 844497));
    catPicturesDirectory.addFile(ImageFile('Cat 2.jpg', 975363));
    catPicturesDirectory.addFile(ImageFile('Cat 3.png', 1975363));

    var picturesDirectory = Directory('Pictures');
    picturesDirectory.addFile(catPicturesDirectory);
    picturesDirectory.addFile(ImageFile('Not a cat.png', 2971361));

    var mediaDirectory = Directory('Media', true);
    mediaDirectory.addFile(musicDirectory);
    mediaDirectory.addFile(moviesDirectory);
    mediaDirectory.addFile(picturesDirectory);
    mediaDirectory.addFile(Directory('New Folder'));
    mediaDirectory.addFile(TextFile('Nothing suspicious there.txt', 430791));
    mediaDirectory.addFile(TextFile('TeamTrees.txt', 1042));

    return mediaDirectory;
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: paddingL),
        child: buildMediaDirectory(),
      ),
    );
  }
}
