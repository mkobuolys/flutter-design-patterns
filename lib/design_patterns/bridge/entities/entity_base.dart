import 'package:faker/faker.dart';

abstract class EntityBase {
  String id;

  EntityBase() {
    id = faker.guid.guid();
  }
}
