import 'entities/entity_base.dart';

abstract class IStorage {
  String getTitle();
  List<EntityBase> fetchAll<T extends EntityBase>();
  void store<T extends EntityBase>(T entityBase);
}
