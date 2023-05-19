## Class diagram

![Visitor Class Diagram](resource:assets/images/visitor/visitor.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of the **Visitor** design pattern:

![Visitor Implementation Class Diagram](resource:assets/images/visitor/visitor_implementation.png)

`IFile` defines a common interface for both `File` and `Directory` classes:

- `getSize()` - returns the size of the file;
- `render()` - renders the component's UI;
- `accept()` - delegates request to a visitor.

`File` class implements the `getSize()` and `render()` methods, additionally contains `title`, `fileExtension`, `size` and `icon` properties.

`AudioFile`, `ImageFile`, `TextFile` and `VideoFile` are concrete file classes implementing the `accept()` method from `IFile` interface and containing some additional information about the specific file.

`Directory` implements the same required methods as `File`, but it also contains `title`, `level`, `isInitiallyExpanded` properties and `files` list, containing the `IFile` objects. It also defines the `addFile()` method, which allows adding `IFile` objects to the directory (`files` list). Similarly as in specific file classes, `accept()` method is implemented here as well.

`IVisitor` defines a common interface for the specific visitor classes:

- `getTitle()` - returns the title of the visitor that is used in the UI;
- `visitDirectory()` - defines a visiting method for the `Directory` class;
- `visitAudioFile()` - defines a visiting method for the `AudioFile` class;
- `visitImageFile()` - defines a visiting method for the `ImageFile` class;
- `visitTextFile()` - defines a visiting method for the `TextFile` class;
- `visitVideoFile()` - defines a visiting method for the `VideoFile` class.

`HumanReadableVisitor` and `XmlVisitor` are concrete visitor classes that implement visit methods for each specific file type.

`VisitorExample` contains a list of visitors implementing the `IVisitor` interface and the composite file structure. The selected visitor is used to format the visible files structure as text and provide it to the UI.

### IFile

An interface that defines methods to be implemented by specific files and directories. The interface also defines an `accept()` method which is used for the Visitor design pattern implementation.

```dart
abstract interface class IFile {
  int getSize();
  Widget render(BuildContext context);
  String accept(IVisitor visitor);
}
```

### File

A concrete implementation of the `IFile` interface. In `File` class, `getSize()` method simply returns the file size, `render()` - returns file's UI widget which is used in the example screen.

```dart
abstract class File extends StatelessWidget implements IFile {
  final String title;
  final String fileExtension;
  final int size;
  final IconData icon;

  const File({
    required this.title,
    required this.fileExtension,
    required this.size,
    required this.icon,
  });

  @override
  int getSize() => size;

  @override
  Widget render(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: LayoutConstants.paddingS),
      child: ListTile(
        title: Text(
          '$title.$fileExtension',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        leading: Icon(icon),
        trailing: Text(
          FileSizeConverter.bytesToString(size),
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.black54),
        ),
        dense: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => render(context);
}
```

### Concrete file classes

All of the specific file type classes implement the `accept()` method that delegates request to the specific visitor's method.

- `AudioFile` - a specific file class representing the audio file type that contains an additional `albumTitle` property.

```dart
class AudioFile extends File {
  const AudioFile({
    required this.albumTitle,
    required super.title,
    required super.fileExtension,
    required super.size,
  }) : super(icon: Icons.music_note);

  final String albumTitle;

  @override
  String accept(IVisitor visitor) => visitor.visitAudioFile(this);
}
```

- `ImageFile` - a specific file class representing the image file type that contains an additional `resolution` property.

```dart
class ImageFile extends File {
  const ImageFile({
    required this.resolution,
    required super.title,
    required super.fileExtension,
    required super.size,
  }) : super(icon: Icons.image);

  final String resolution;

  @override
  String accept(IVisitor visitor) => visitor.visitImageFile(this);
}
```

- `TextFile` - a specific file class representing the text file type that contains an additional `content` property.

```dart
class TextFile extends File {
  const TextFile({
    required this.content,
    required super.title,
    required super.fileExtension,
    required super.size,
  }) : super(icon: Icons.description);

  final String content;

  @override
  String accept(IVisitor visitor) => visitor.visitTextFile(this);
}
```

- `VideoFile` - a specific file class representing the video file type that contains an additional `directedBy` property.

```dart
class VideoFile extends File {
  const VideoFile({
    required this.directedBy,
    required super.title,
    required super.fileExtension,
    required super.size,
  }) : super(icon: Icons.movie);

  final String directedBy;

  @override
  String accept(IVisitor visitor) => visitor.visitVideoFile(this);
}
```

### Directory

A concrete implementation of the `IFile` interface. Similarly as in `File` class, `render()` returns directory's UI widget which is used in the example screen. However, in this class `getSize()` method calculates the directory size by calling the `getSize()` method for each item in the `files` list and adding up the results. Also, the class implements the `accept()` method that delegates request to the specific visitor's method for the directory.

```dart
class Directory extends StatelessWidget implements IFile {
  final String title;
  final int level;
  final bool isInitiallyExpanded;

  final List<IFile> _files = [];
  List<IFile> get files => _files;

  Directory({
    required this.title,
    required this.level,
    this.isInitiallyExpanded = false,
  });

  void addFile(IFile file) => _files.add(file);

  @override
  int getSize() {
    var sum = 0;

    for (final file in _files) {
      sum += file.getSize();
    }

    return sum;
  }

  @override
  Widget render(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(primary: Colors.black),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: LayoutConstants.paddingS),
        child: ExpansionTile(
          leading: const Icon(Icons.folder),
          title: Text('$title (${FileSizeConverter.bytesToString(getSize())})'),
          initiallyExpanded: isInitiallyExpanded,
          children: _files.map((IFile file) => file.render(context)).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => render(context);

  @override
  String accept(IVisitor visitor) => visitor.visitDirectory(this);
}
```

### IVisitor

An interface which defines methods to be implemented by all specific visitors.

```dart
abstract interface class IVisitor {
  String getTitle();
  String visitDirectory(Directory directory);
  String visitAudioFile(AudioFile file);
  String visitImageFile(ImageFile file);
  String visitTextFile(TextFile file);
  String visitVideoFile(VideoFile file);
}
```

### Concrete visitors

- `HumanReadableVisitor` - implements the specific visitor that provides file information of each file type in a human-readable format.

```dart
class HumanReadableVisitor implements IVisitor {
  const HumanReadableVisitor();

  @override
  String getTitle() => 'Export as text';

  @override
  String visitAudioFile(AudioFile file) {
    final fileInfo = <String, String>{
      'Type': 'Audio',
      'Album': file.albumTitle,
      'Extension': file.fileExtension,
      'Size': FileSizeConverter.bytesToString(file.getSize()),
    };

    return _formatFile(file.title, fileInfo);
  }

  @override
  String visitDirectory(Directory directory) {
    final buffer = StringBuffer();

    for (final file in directory.files) {
      buffer.write(file.accept(this));
    }

    return buffer.toString();
  }

  @override
  String visitImageFile(ImageFile file) {
    final fileInfo = <String, String>{
      'Type': 'Image',
      'Resolution': file.resolution,
      'Extension': file.fileExtension,
      'Size': FileSizeConverter.bytesToString(file.getSize()),
    };

    return _formatFile(file.title, fileInfo);
  }

  @override
  String visitTextFile(TextFile file) {
    final fileContentPreview = file.content.length > 30
        ? '${file.content.substring(0, 30)}...'
        : file.content;

    final fileInfo = <String, String>{
      'Type': 'Text',
      'Preview': fileContentPreview,
      'Extension': file.fileExtension,
      'Size': FileSizeConverter.bytesToString(file.getSize()),
    };

    return _formatFile(file.title, fileInfo);
  }

  @override
  String visitVideoFile(VideoFile file) {
    final fileInfo = <String, String>{
      'Type': 'Video',
      'Directed by': file.directedBy,
      'Extension': file.fileExtension,
      'Size': FileSizeConverter.bytesToString(file.getSize()),
    };

    return _formatFile(file.title, fileInfo);
  }

  String _formatFile(String title, Map<String, String> fileInfo) {
    final buffer = StringBuffer();

    buffer.write('$title:\n');

    for (final entry in fileInfo.entries) {
      buffer.write('${entry.key}: ${entry.value}'.indentAndAddNewLine(2));
    }

    return buffer.toString();
  }
}
```

- `XmlVisitor` - implements the specific visitor that provides file information of each file type in XML format.

```dart
class XmlVisitor implements IVisitor {
  const XmlVisitor();

  @override
  String getTitle() => 'Export as XML';

  @override
  String visitAudioFile(AudioFile file) {
    final fileInfo = <String, String>{
      'title': file.title,
      'album': file.albumTitle,
      'extension': file.fileExtension,
      'size': FileSizeConverter.bytesToString(file.getSize()),
    };

    return _formatFile('audio', fileInfo);
  }

  @override
  String visitDirectory(Directory directory) {
    final isRootDirectory = directory.level == 0;
    final buffer = StringBuffer();

    if (isRootDirectory) buffer.write('<files>\n');

    for (final file in directory.files) {
      buffer.write(file.accept(this));
    }

    if (isRootDirectory) buffer.write('</files>\n');

    return buffer.toString();
  }

  @override
  String visitImageFile(ImageFile file) {
    final fileInfo = <String, String>{
      'title': file.title,
      'resolution': file.resolution,
      'extension': file.fileExtension,
      'size': FileSizeConverter.bytesToString(file.getSize()),
    };

    return _formatFile('image', fileInfo);
  }

  @override
  String visitTextFile(TextFile file) {
    final fileContentPreview = file.content.length > 30
        ? '${file.content.substring(0, 30)}...'
        : file.content;

    final fileInfo = <String, String>{
      'title': file.title,
      'preview': fileContentPreview,
      'extension': file.fileExtension,
      'size': FileSizeConverter.bytesToString(file.getSize()),
    };

    return _formatFile('text', fileInfo);
  }

  @override
  String visitVideoFile(VideoFile file) {
    final fileInfo = <String, String>{
      'title': file.title,
      'directed_by': file.directedBy,
      'extension': file.fileExtension,
      'size': FileSizeConverter.bytesToString(file.getSize()),
    };

    return _formatFile('video', fileInfo);
  }

  String _formatFile(String type, Map<String, String> fileInfo) {
    final buffer = StringBuffer();

    buffer.write('<$type>'.indentAndAddNewLine(2));

    for (final entry in fileInfo.entries) {
      buffer.write(
        '<${entry.key}>${entry.value}</${entry.key}>'.indentAndAddNewLine(4),
      );
    }

    buffer.write('</$type>'.indentAndAddNewLine(2));

    return buffer.toString();
  }
}
```

### Example

The `VisitorExample` widget contains the `buildMediaDirectory()` method which builds the file structure for the example. Also, it contains a list of different visitors and provides it to the `FilesVisitorSelection` widget where the index of a specific visitor is selected by triggering the `setSelectedVisitorIndex()` method.

When exporting files' information and providing it in the modal via the `showFilesDialog()` method, the example widget does not care about the concrete selected visitor as long as it implements the `IVisitor` interface. The selected visitor is just applied to the whole file structure by passing it as a parameter to the `accept()` method, hence retrieving the formatted files' structure as text and providing it to the opened `FilesDialog` modal.

```dart
class VisitorExample extends StatefulWidget {
  const VisitorExample();

  @override
  _VisitorExampleState createState() => _VisitorExampleState();
}

class _VisitorExampleState extends State<VisitorExample> {
  final visitorsList = const [HumanReadableVisitor(), XmlVisitor()];

  late final IFile _rootDirectory;
  var _selectedVisitorIndex = 0;

  @override
  void initState() {
    super.initState();

    _rootDirectory = _buildMediaDirectory();
  }

  IFile _buildMediaDirectory() {
    final musicDirectory = Directory(title: 'Music', level: 1)
      ..addFile(
        const AudioFile(
          title: 'Darude - Sandstorm',
          albumTitle: 'Before the Storm',
          fileExtension: 'mp3',
          size: 2612453,
        ),
      )
      ..addFile(
        const AudioFile(
          title: 'Toto - Africa',
          albumTitle: 'Toto IV',
          fileExtension: 'mp3',
          size: 3219811,
        ),
      )
      ..addFile(
        const AudioFile(
          title: 'Bag Raiders - Shooting Stars',
          albumTitle: 'Bag Raiders',
          fileExtension: 'mp3',
          size: 3811214,
        ),
      );

    final moviesDirectory = Directory(title: 'Movies', level: 1)
      ..addFile(
        const VideoFile(
          title: 'The Matrix',
          directedBy: 'The Wachowskis',
          fileExtension: 'avi',
          size: 951495532,
        ),
      )
      ..addFile(
        const VideoFile(
          title: 'Pulp Fiction',
          directedBy: 'Quentin Tarantino',
          fileExtension: 'mp4',
          size: 1251495532,
        ),
      );

    final catPicturesDirectory = Directory(title: 'Cats', level: 2)
      ..addFile(
        const ImageFile(
          title: 'Cat 1',
          resolution: '640x480px',
          fileExtension: 'jpg',
          size: 844497,
        ),
      )
      ..addFile(
        const ImageFile(
          title: 'Cat 2',
          resolution: '1280x720px',
          fileExtension: 'jpg',
          size: 975363,
        ),
      )
      ..addFile(
        const ImageFile(
          title: 'Cat 3',
          resolution: '1920x1080px',
          fileExtension: 'png',
          size: 1975363,
        ),
      );

    final picturesDirectory = Directory(title: 'Pictures', level: 1)
      ..addFile(catPicturesDirectory)
      ..addFile(
        const ImageFile(
          title: 'Not a cat',
          resolution: '2560x1440px',
          fileExtension: 'png',
          size: 2971361,
        ),
      );

    final mediaDirectory = Directory(
      title: 'Media',
      level: 0,
      isInitiallyExpanded: true,
    )
      ..addFile(musicDirectory)
      ..addFile(moviesDirectory)
      ..addFile(picturesDirectory)
      ..addFile(Directory(title: 'New Folder', level: 1))
      ..addFile(
        const TextFile(
          title: 'Nothing suspicious there',
          content: 'Just a normal text file without any sensitive information.',
          fileExtension: 'txt',
          size: 430791,
        ),
      )
      ..addFile(
        const TextFile(
          title: 'TeamTrees',
          content:
              'Team Trees, also known as #teamtrees, is a collaborative fundraiser that managed to raise 20 million U.S. dollars before 2020 to plant 20 million trees.',
          fileExtension: 'txt',
          size: 1042,
        ),
      );

    return mediaDirectory;
  }

  void _setSelectedVisitorIndex(int? index) {
    if (index == null) return;

    setState(() => _selectedVisitorIndex = index);
  }

  void _showFilesDialog() {
    final selectedVisitor = visitorsList[_selectedVisitorIndex];
    final filesText = _rootDirectory.accept(selectedVisitor);

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => FilesDialog(filesText: filesText),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: LayoutConstants.paddingL,
        ),
        child: Column(
          children: [
            FilesVisitorSelection(
              visitorsList: visitorsList,
              selectedIndex: _selectedVisitorIndex,
              onChanged: _setSelectedVisitorIndex,
            ),
            PlatformButton(
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _showFilesDialog,
              text: 'Export files',
            ),
            const SizedBox(height: LayoutConstants.spaceL),
            _rootDirectory.render(context),
          ],
        ),
      ),
    );
  }
}
```
