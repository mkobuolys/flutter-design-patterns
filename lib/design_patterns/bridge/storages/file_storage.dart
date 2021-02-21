import '../entities/entity_base.dart';
import '../istorage.dart';
import '../json_helper.dart';

class FileStorage implements IStorage {
  final Map<Type, List<String>> fileStorage = {};

  @override
  String getTitle() {
    return 'File Storage';
  }

  @override
  List<T> fetchAll<T extends EntityBase>() {
    if (fileStorage.containsKey(T)) {
      final files = fileStorage[T];

      return files.map<T>((f) => JsonHelper.deserialiseObject<T>(f)).toList();
    }

    return [];
  }

  @override
  void store<T extends EntityBase>(T entityBase) {
    if (!fileStorage.containsKey(T)) {
      fileStorage[T] = [];
    }

    fileStorage[T].add(JsonHelper.serialiseObject(entityBase));
  }
}
