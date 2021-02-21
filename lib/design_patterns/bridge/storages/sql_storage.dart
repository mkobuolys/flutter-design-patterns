import '../entities/entity_base.dart';
import '../istorage.dart';

class SqlStorage implements IStorage {
  final Map<Type, List<EntityBase>> sqlStorage = {};

  @override
  String getTitle() {
    return 'SQL Storage';
  }

  @override
  List<EntityBase> fetchAll<T extends EntityBase>() {
    return sqlStorage.containsKey(T) ? sqlStorage[T] : [];
  }

  @override
  void store<T extends EntityBase>(T entityBase) {
    if (!sqlStorage.containsKey(T)) {
      sqlStorage[T] = <T>[];
    }

    sqlStorage[T].add(entityBase);
  }
}
