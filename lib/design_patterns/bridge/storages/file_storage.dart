import 'dart:convert';

import 'package:flutter_design_patterns/design_patterns/bridge/entities/entity_base.dart';
import 'package:flutter_design_patterns/design_patterns/bridge/istorage.dart';

class FileStorage implements IStorage {
  Map<Type, List<String>> fileStorage = Map<Type, List<String>>();

  @override
  List<T> fetchAll<T extends EntityBase>() {
    if (fileStorage.containsKey(T)) {
      var files = fileStorage[T];

      return files.map<T>((f) => jsonDecode(f));
    }

    return List<T>();
  }

  @override
  void store<T extends EntityBase>(T entityBase) {
    if (!fileStorage.containsKey(T)) {
      fileStorage[T] = List<String>();
    }

    fileStorage[T].add(jsonEncode(entityBase));
  }
}
