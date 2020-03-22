import 'package:flutter_design_patterns/design_patterns/bridge/entities/entity_base.dart';
import 'package:flutter_design_patterns/design_patterns/bridge/entities/order.dart';
import 'package:flutter_design_patterns/design_patterns/bridge/irepository.dart';
import 'package:flutter_design_patterns/design_patterns/bridge/istorage.dart';

class OrdersRepository implements IRepository {
  final IStorage storage;

  const OrdersRepository(this.storage);

  @override
  List<EntityBase> getAll() {
    return storage.fetchAll<Order>();
  }

  @override
  void save(EntityBase entityBase) {
    storage.store(entityBase);
  }
}
