import 'package:flutter_design_patterns/design_patterns/bridge/entities/entity_base.dart';

abstract class IStorage {
  List<T> fetchAll<T extends EntityBase>();
  void store<T extends EntityBase>(T entityBase);
}
