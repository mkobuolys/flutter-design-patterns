## Class diagram

![Composite Class Diagram](resource:assets/images/composite/composite.png)

## Implementation

### Class diagram
The class diagram below shows the implementation of **Composite** design pattern.

![Composite Implementation Class Diagram](resource:assets/images/composite/composite_implementation.png)

*IFile* defines a common interface for both *File* (leaf) and *Directory* (composite) classes:

* *getSize()* -  returns size of the file; 
* *render()* - renders the component's UI.

*File* class implements the *getSize()* and *render()* methods, additionally contains *title*, *size* and *icon* properties. *Directory* implements the same required methods, but it also contains *title*, *isInitiallyExpanded* and *files* list, containing the *IFile* objects, defines *addFile()* method, which allows to add *IFile* objects to the directory (*files* list). *AudioFile*, *ImageFile*, *TextFile* and *VideoFile* classes extend the *File* class to specify a concrete type of the file.

### IFile

An interface which defines methods to be implemented by leaf and composite components. Dart language does not support the interface as a class type, so we define an interface by creating an abstract class and providing a method header (name, return type, parameters) without the default implementation.

``` 
abstract class IFile {
  int getSize();
  Widget render(BuildContext context);
}
```

### File

A concrete implementation of the *IFile* interface which matches the *leaf* class in the Composite design pattern. In *File* class, *getSize()* method simply returns the file size, *render()* - returns file's UI widget which is used in the example screen.

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
```

### Concrete classes extending File

All of these classes extend the *File* class and specify the concrete file type by providing a unique icon for the corresponding file type.

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

A concrete implementation of the *IFile* interface which matches the *composite* class in the Composite design pattern. Similarly as in *File* class, *render()* returns directory's UI widget which is used in the example screen. However, in this class *getSize()* method calculates the directory size by calling the *getSize()* method for each item in the *files* list and adding up the results. This is the main idea of the Composite design pattern which allows the composite class to treat all the elements in the containing list uniformly as long as they implement the same interface.

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

*CompositeExample* widget contains the *buildMediaDirectory()* method which builds the file structure for the example. This method illustrates the Composite design pattern - even though the components are of a different type, they could be handled in the same manner since the implemented interface of *IFile* is the same for all components. This allows us to put *Directory* objects inside other directories, mix them along with concrete *File* objects hence building the tree structure of *IFile* components.

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

