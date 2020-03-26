import 'package:flutter_design_patterns/design_patterns/bridge/entities/entity_base.dart';
import 'package:flutter_design_patterns/design_patterns/bridge/istorage.dart';

class SqlStorage implements IStorage {
  Map<Type, List<EntityBase>> sqlStorage = Map<Type, List<EntityBase>>();

  @override
  String getTitle() {
    return 'SQL Storage';
  }

  @override
  List<T> fetchAll<T extends EntityBase>() {
    return sqlStorage.containsKey(T) ? sqlStorage[T] : List<T>();
  }

  @override
  void store<T extends EntityBase>(T entityBase) {
    if (!sqlStorage.containsKey(T)) {
      sqlStorage[T] = List<T>();
    }

    sqlStorage[T].add(entityBase);
  }
}
