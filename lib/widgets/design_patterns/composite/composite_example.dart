import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'directory.dart';
import 'files/audio_file.dart';
import 'files/image_file.dart';
import 'files/text_file.dart';
import 'files/video_file.dart';

class CompositeExample extends StatelessWidget {
  Widget buildMediaDirectory() {
    final musicDirectory = Directory('Music');
    musicDirectory.addFile(const AudioFile('Darude - Sandstorm.mp3', 2612453));
    musicDirectory.addFile(const AudioFile('Toto - Africa.mp3', 3219811));
    musicDirectory
        .addFile(const AudioFile('Bag Raiders - Shooting Stars.mp3', 3811214));

    final moviesDirectory = Directory('Movies');

    moviesDirectory.addFile(const VideoFile('The Matrix.avi', 951495532));
    moviesDirectory
        .addFile(const VideoFile('The Matrix Reloaded.mp4', 1251495532));

    final catPicturesDirectory = Directory('Cats');
    catPicturesDirectory.addFile(const ImageFile('Cat 1.jpg', 844497));
    catPicturesDirectory.addFile(const ImageFile('Cat 2.jpg', 975363));
    catPicturesDirectory.addFile(const ImageFile('Cat 3.png', 1975363));

    final picturesDirectory = Directory('Pictures');
    picturesDirectory.addFile(catPicturesDirectory);
    picturesDirectory.addFile(const ImageFile('Not a cat.png', 2971361));

    final mediaDirectory = Directory('Media', isInitiallyExpanded: true);
    mediaDirectory.addFile(musicDirectory);
    mediaDirectory.addFile(moviesDirectory);
    mediaDirectory.addFile(picturesDirectory);
    mediaDirectory.addFile(Directory('New Folder'));
    mediaDirectory
        .addFile(const TextFile('Nothing suspicious there.txt', 430791));
    mediaDirectory.addFile(const TextFile('TeamTrees.txt', 1042));

    return mediaDirectory;
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: paddingL),
        child: buildMediaDirectory(),
      ),
    );
  }
}
