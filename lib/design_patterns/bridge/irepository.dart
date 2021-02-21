import 'entities/entity_base.dart';

abstract class IRepository {
  List<EntityBase> getAll();
  void save(EntityBase entityBase);
}
