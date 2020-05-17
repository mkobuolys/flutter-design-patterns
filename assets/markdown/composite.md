## Class diagram

![Composite Class Diagram](resource:assets/images/composite/composite.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of **Composite** design pattern.

![Composite Implementation Class Diagram](resource:assets/images/composite/composite_implementation.png)

_IFile_ defines a common interface for both _File_ (leaf) and _Directory_ (composite) classes:

- _getSize()_ - returns size of the file;
- _render()_ - renders the component's UI.

_File_ class implements the _getSize()_ and _render()_ methods, additionally contains _title_, _size_ and _icon_ properties. _Directory_ implements the same required methods, but it also contains _title_, _isInitiallyExpanded_ and _files_ list, containing the _IFile_ objects, defines _addFile()_ method, which allows adding _IFile_ objects to the directory (_files_ list). _AudioFile_, _ImageFile_, _TextFile_ and _VideoFile_ classes extend the _File_ class to specify a concrete type of the file.

### IFile

An interface which defines methods to be implemented by leaf and composite components. Dart language does not support the interface as a class type, so we define an interface by creating an abstract class and providing a method header (name, return type, parameters) without the default implementation.

```
abstract class IFile {
  int getSize();
  Widget render(BuildContext context);
}
```

### File

A concrete implementation of the _IFile_ interface which matches the _leaf_ class in the Composite design pattern. In _File_ class, _getSize()_ method simply returns the file size, _render()_ - returns file's UI widget which is used in the example screen.

```
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
          style: Theme.of(context).textTheme.bodyText1,
        ),
        leading: Icon(icon),
        trailing: Text(
          FileSizeConverter.bytesToString(size),
          style:
              Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.black54),
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
```

### Concrete classes extending File

All of these classes extend the _File_ class and specify the concrete file type by providing a unique icon for the corresponding file type.

```
class AudioFile extends File {
  AudioFile(String title, int size) : super(title, size, Icons.music_note);
}

class ImageFile extends File {
  ImageFile(String title, int size) : super(title, size, Icons.image);
}

class TextFile extends File {
  TextFile(String title, int size) : super(title, size, Icons.description);
}

class VideoFile extends File {
  VideoFile(String title, int size) : super(title, size, Icons.movie);
}
```

### Directory

A concrete implementation of the _IFile_ interface which matches the _composite_ class in the Composite design pattern. Similar as in _File_ class, _render()_ returns directory's UI widget which is used in the example screen. However, in this class _getSize()_ method calculates the directory size by calling the _getSize()_ method for each item in the _files_ list and adding up the results. This is the main idea of the Composite design pattern which allows the composite class to treat all the elements in the containing list uniformly as long as they implement the same interface.

```
class Directory extends StatelessWidget implements IFile {
  final String title;
  final bool isInitiallyExpanded;

  final List<IFile> files = List<IFile>();

  Directory(this.title, [this.isInitiallyExpanded = false]);

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
}
```

### Example

_CompositeExample_ widget contains the _buildMediaDirectory()_ method which builds the file structure for the example. This method illustrates the Composite design pattern - even though the components are of a different type, they could be handled in the same manner since the implemented interface of _IFile_ is the same for all components. This allows us to put _Directory_ objects inside other directories, mix them along with concrete _File_ objects hence building the tree structure of _IFile_ components.

```
class CompositeExample extends StatelessWidget {
  Widget buildMediaDirectory() {
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
```
