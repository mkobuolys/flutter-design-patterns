## Class diagram

![Visitor Class Diagram](resource:assets/images/visitor/visitor.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of the **Visitor** design pattern:

![Visitor Implementation Class Diagram](resource:assets/images/visitor/visitor_implementation.png)

_IFile_ defines a common interface for both _File_ and _Directory_ classes:

- _getSize()_ - returns the size of the file;
- _render()_ - renders the component's UI;
- _accept()_ - delegates request to a visitor.

_File_ class implements the _getSize()_ and _render()_ methods, additionally contains _title_, _fileExtension_, _size_ and _icon_ properties.

_AudioFile_, _ImageFile_, _TextFile_ and _VideoFile_ are concrete file classes implementing the _accept()_ method from _IFile_ interface and containing some additional information about the specific file.

_Directory_ implements the same required methods as _File_, but it also contains _title_, _level_, _isInitiallyExpanded_ properties and _files_ list, containing the _IFile_ objects. It also defines the _addFile()_ method, which allows adding _IFile_ objects to the directory (_files_ list). Similarly as in specific file classes, _accept()_ method is implemented here as well.

_IVisitor_ defines a common interface for the specific visitor classes:

- _getTitle()_ - returns the title of the visitor that is used in the UI;
- _visitDirectory()_ - defines a visiting method for the _Directory_ class;
- _visitAudioFile()_ - defines a visiting method for the _AudioFile_ class;
- _visitImageFile()_ - defines a visiting method for the _ImageFile_ class;
- _visitTextFile()_ - defines a visiting method for the _TextFile_ class;
- _visitVideoFile()_ - defines a visiting method for the _VideoFile_ class.

_HumanReadableVisitor_ and _XmlVisitor_ are concrete visitor classes that implement visit methods for each specific file type.

_VisitorExample_ contains a list of visitors implementing the _IVisitor_ interface and the composite file structure. The selected visitor is used to format the visible files structure as text and provide it to the UI.

### IFile

An interface which defines methods to be implemented by specific files and directories. The interface also defines an _accept()_ method which is used for the Visitor design pattern implementation. Dart language does not support the interface as a class type, so we define an interface by creating an abstract class and providing a method header (name, return type, parameters) without the default implementation.

```
abstract class IFile {
  int getSize();
  Widget render(BuildContext context);
  String accept(IVisitor visitor);
}
```

### File

A concrete implementation of the _IFile_ interface. In _File_ class, _getSize()_ method simply returns the file size, _render()_ - returns file's UI widget which is used in the example screen.

```
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
```

### Concrete file classes

All of the specific file type classes implement the _accept()_ method that delegates request to the specific visitor's method.

- _AudioFile_ - a specific file class representing the audio file type that contains an additional _albumTitle_ property.

```
class AudioFile extends File {
  final String albumTitle;

  const AudioFile(String title, this.albumTitle, String fileExtension, int size)
      : super(title, fileExtension, size, Icons.music_note);

  @override
  String accept(IVisitor visitor) {
    return visitor.visitAudioFile(this);
  }
}
```

- _ImageFile_ - a specific file class representing the image file type that contains an additional _resolution_ property.

```
class ImageFile extends File {
  final String resolution;

  const ImageFile(String title, this.resolution, String fileExtension, int size)
      : super(title, fileExtension, size, Icons.image);

  @override
  String accept(IVisitor visitor) {
    return visitor.visitImageFile(this);
  }
}
```

- _TextFile_ - a specific file class representing the text file type that contains an additional _content_ property.

```
class TextFile extends File {
  final String content;

  const TextFile(String title, this.content, String fileExtension, int size)
      : super(title, fileExtension, size, Icons.description);

  @override
  String accept(IVisitor visitor) {
    return visitor.visitTextFile(this);
  }
}
```

- _VideoFile_ - a specific file class representing the video file type that contains an additional _directedBy_ property.

```
class VideoFile extends File {
  final String directedBy;

  const VideoFile(String title, this.directedBy, String fileExtension, int size)
      : super(title, fileExtension, size, Icons.movie);

  @override
  String accept(IVisitor visitor) {
    return visitor.visitVideoFile(this);
  }
}
```

### Directory

A concrete implementation of the _IFile_ interface. Similarly as in _File_ class, _render()_ returns directory's UI widget which is used in the example screen. However, in this class _getSize()_ method calculates the directory size by calling the _getSize()_ method for each item in the _files_ list and adding up the results. Also, the class implements the _accept()_ method that delegates request to the specific visitor's method for the directory.

```
class Directory extends StatelessWidget implements IFile {
  final String title;
  final int level;
  final bool isInitiallyExpanded;

  final List<IFile> _files = List<IFile>();
  List<IFile> get files => _files;

  Directory({
    @required this.title,
    @required this.level,
    this.isInitiallyExpanded = false,
  })  : assert(title != null),
        assert(level != null);

  void addFile(IFile file) {
    _files.add(file);
  }

  @override
  int getSize() {
    var sum = 0;
    _files.forEach((IFile file) => sum += file.getSize());
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
          children: _files.map((IFile file) => file.render(context)).toList(),
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
  String accept(IVisitor visitor) {
    return visitor.visitDirectory(this);
  }
}
```

### IVisitor

An interface which defines methods to be implemented by all specific visitors.

```
abstract class IVisitor {
  String getTitle();
  String visitDirectory(Directory directory);
  String visitAudioFile(AudioFile file);
  String visitImageFile(ImageFile file);
  String visitTextFile(TextFile file);
  String visitVideoFile(VideoFile file);
}
```

### Concrete visitors

- _HumanReadableVisitor_ - implements the specific visitor that provides file information of each file type in a human-readable format.

```
class HumanReadableVisitor implements IVisitor {
  @override
  String getTitle() => 'Export as text';

  @override
  String visitAudioFile(AudioFile file) {
    var fileInfo = <String, String>{
      'Type': 'Audio',
      'Album': file.albumTitle,
      'Extension': file.fileExtension,
      'Size': FileSizeConverter.bytesToString(file.getSize()),
    };

    return _formatFile(file.title, fileInfo);
  }

  @override
  String visitDirectory(Directory directory) {
    String directoryText = "";

    for (var file in directory.files) {
      directoryText += "${file.accept(this)}";
    }

    return directoryText;
  }

  @override
  String visitImageFile(ImageFile file) {
    var fileInfo = <String, String>{
      'Type': 'Image',
      'Resolution': file.resolution,
      'Extension': file.fileExtension,
      'Size': FileSizeConverter.bytesToString(file.getSize()),
    };

    return _formatFile(file.title, fileInfo);
  }

  @override
  String visitTextFile(TextFile file) {
    String fileContentPreview = file.content.length > 30
        ? '${file.content.substring(0, 30)}...'
        : file.content;

    var fileInfo = <String, String>{
      'Type': 'Text',
      'Preview': fileContentPreview,
      'Extension': file.fileExtension,
      'Size': FileSizeConverter.bytesToString(file.getSize()),
    };

    return _formatFile(file.title, fileInfo);
  }

  @override
  String visitVideoFile(VideoFile file) {
    var fileInfo = <String, String>{
      'Type': 'Video',
      'Directed by': file.directedBy,
      'Extension': file.fileExtension,
      'Size': FileSizeConverter.bytesToString(file.getSize()),
    };

    return _formatFile(file.title, fileInfo);
  }

  String _formatFile(String title, Map<String, String> fileInfo) {
    String formattedFile = '$title:\n';

    for (var entry in fileInfo.entries) {
      formattedFile += '${entry.key}: ${entry.value}'.indentAndAddNewLine(2);
    }

    return formattedFile;
  }
}
```

- _XmlVisitor_ - implements the specific visitor that provides file information of each file type in XML format.

```
class XmlVisitor implements IVisitor {
  @override
  String getTitle() => 'Export as XML';

  @override
  String visitAudioFile(AudioFile file) {
    var fileInfo = <String, String>{
      'title': file.title,
      'album': file.albumTitle,
      'extension': file.fileExtension,
      'size': FileSizeConverter.bytesToString(file.getSize()),
    };

    return _formatFile('audio', fileInfo);
  }

  @override
  String visitDirectory(Directory directory) {
    bool isRootDirectory = directory.level == 0;

    String directoryText = isRootDirectory ? '<files>\n' : '';

    for (var file in directory.files) {
      directoryText += "${file.accept(this)}";
    }

    return isRootDirectory ? '$directoryText</files>\n' : directoryText;
  }

  @override
  String visitImageFile(ImageFile file) {
    var fileInfo = <String, String>{
      'title': file.title,
      'resolution': file.resolution,
      'extension': file.fileExtension,
      'size': FileSizeConverter.bytesToString(file.getSize()),
    };

    return _formatFile('image', fileInfo);
  }

  @override
  String visitTextFile(TextFile file) {
    String fileContentPreview = file.content.length > 30
        ? '${file.content.substring(0, 30)}...'
        : file.content;

    var fileInfo = <String, String>{
      'title': file.title,
      'preview': fileContentPreview,
      'extension': file.fileExtension,
      'size': FileSizeConverter.bytesToString(file.getSize()),
    };

    return _formatFile('text', fileInfo);
  }

  @override
  String visitVideoFile(VideoFile file) {
    var fileInfo = <String, String>{
      'title': file.title,
      'directed_by': file.directedBy,
      'extension': file.fileExtension,
      'size': FileSizeConverter.bytesToString(file.getSize()),
    };

    return _formatFile('video', fileInfo);
  }

  String _formatFile(String type, Map<String, String> fileInfo) {
    String formattedFile = '<$type>'.indentAndAddNewLine(2);

    for (var entry in fileInfo.entries) {
      formattedFile +=
          '<${entry.key}>${entry.value}</${entry.key}>'.indentAndAddNewLine(4);
    }

    formattedFile += '</$type>'.indentAndAddNewLine(2);

    return formattedFile;
  }
}
```

### Example

The _VisitorExample_ widget contains the _buildMediaDirectory()_ method which builds the file structure for the example. Also, it contains a list of different visitors and provides it to the _FilesVisitorSelection_ widget where the index of a specific visitor is selected by triggering the _setSelectedVisitorIndex()_ method.

When exporting files' information and providing it in the modal via the _showFilesDialog()_ method, the example widget does not care about the concrete selected visitor as long as it implements the _IVisitor_ interface. The selected visitor is just applied to the whole file structure by passing it as a parameter to the _accept()_ method, hence retrieving the formatted files' structure as text and providing it to the opened _FilesDialog_ modal.

```
class VisitorExample extends StatefulWidget {
  @override
  _VisitorExampleState createState() => _VisitorExampleState();
}

class _VisitorExampleState extends State<VisitorExample> {
  final List<IVisitor> visitorsList = [
    HumanReadableVisitor(),
    XmlVisitor(),
  ];

  IFile _rootDirectory;
  int _selectedVisitorIndex = 0;

  @override
  void initState() {
    super.initState();

    _rootDirectory = _buildMediaDirectory();
  }

  IFile _buildMediaDirectory() {
    var musicDirectory = Directory(
      title: 'Music',
      level: 1,
    );
    musicDirectory.addFile(
      AudioFile('Darude - Sandstorm', 'Before the Storm', 'mp3', 2612453),
    );
    musicDirectory.addFile(
      AudioFile('Toto - Africa', 'Toto IV', 'mp3', 3219811),
    );
    musicDirectory.addFile(
      AudioFile('Bag Raiders - Shooting Stars', 'Bag Raiders', 'mp3', 3811214),
    );

    var moviesDirectory = Directory(
      title: 'Movies',
      level: 1,
    );
    moviesDirectory.addFile(
      VideoFile('The Matrix', 'The Wachowskis', 'avi', 951495532),
    );
    moviesDirectory.addFile(
      VideoFile('Pulp Fiction', 'Quentin Tarantino', 'mp4', 1251495532),
    );

    var catPicturesDirectory = Directory(
      title: 'Cats',
      level: 2,
    );
    catPicturesDirectory.addFile(
      ImageFile('Cat 1', '640x480px', 'jpg', 844497),
    );
    catPicturesDirectory.addFile(
      ImageFile('Cat 2', '1280x720px', 'jpg', 975363),
    );
    catPicturesDirectory.addFile(
      ImageFile('Cat 3', '1920x1080px', 'png', 1975363),
    );

    var picturesDirectory = Directory(
      title: 'Pictures',
      level: 1,
    );
    picturesDirectory.addFile(catPicturesDirectory);
    picturesDirectory.addFile(
      ImageFile('Not a cat', '2560x1440px', 'png', 2971361),
    );

    var mediaDirectory = Directory(
      title: 'Media',
      level: 0,
      isInitiallyExpanded: true,
    );
    mediaDirectory.addFile(musicDirectory);
    mediaDirectory.addFile(moviesDirectory);
    mediaDirectory.addFile(picturesDirectory);
    mediaDirectory.addFile(
      Directory(
        title: 'New Folder',
        level: 1,
      ),
    );
    mediaDirectory.addFile(
      TextFile(
        'Nothing suspicious there',
        'Just a normal text file without any sensitive information.',
        'txt',
        430791,
      ),
    );
    mediaDirectory.addFile(
      TextFile(
        'TeamTrees',
        'Team Trees, also known as #teamtrees, is a collaborative fundraiser that managed to raise 20 million U.S. dollars before 2020 to plant 20 million trees.',
        'txt',
        1042,
      ),
    );

    return mediaDirectory;
  }

  void _setSelectedVisitorIndex(int index) {
    setState(() {
      _selectedVisitorIndex = index;
    });
  }

  void _showFilesDialog() {
    var selectedVisitor = visitorsList[_selectedVisitorIndex];
    var filesText = _rootDirectory.accept(selectedVisitor);

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext _) => FilesDialog(
        filesText: filesText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: paddingL),
        child: Column(
          children: [
            FilesVisitorSelection(
              visitorsList: visitorsList,
              selectedIndex: _selectedVisitorIndex,
              onChanged: _setSelectedVisitorIndex,
            ),
            PlatformButton(
              child: Text('Export files'),
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _showFilesDialog,
            ),
            const SizedBox(height: spaceL),
            _rootDirectory.render(context),
          ],
        ),
      ),
    );
  }
}
```
