## Class diagram

![Bridge Class Diagram](resource:assets/images/bridge/bridge.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of the **Bridge** design pattern.

![Bridge Implementation Class Diagram](resource:assets/images/bridge/bridge_implementation.png)

The `EntityBase` is an abstract class which is used as a base class for all the entity classes. The class contains an `id` property and a named constructor `EntityBase.fromJson` to map the JSON object to the class field.

`Customer` and `Order` are concrete entities which extend the abstract class `EntityBase`. `Customer` class contains `name` and `email` properties, `Customer.fromJson` named constructor to map the JSON object to class fields and a `toJson()` method to map class fields to the corresponding JSON map object. `Order` class contain `dishes` (a list of dishes of that order) and `total` fields, a named constructor `Order.fromJson` and a `toJson()` method respectively.

`IRepository` defines a common interface for the repositories:

- `getAll()` - returns all records from the repository;
- `save()` - saves an entity of type `EntityBase` in the repository.

`CustomersRepository` and `OrdersRepository` are concrete implementations of the `IRepository` interface. Also, these classes contain a storage property of type `IStorage` which is injected into the repository via the constructor.

`IStorage` defines a common interface for the storages:

- `getTitle()` - returns the title of the storage. The method is used in UI;
- `fetchAll<T>()` - returns all the records of type `T` from the storage;
- `store<T>()` - stores a record of type `T` in the storage.

`FileStorage` and `SqlStorage` are concrete implementations of the `IStorage` interface. Additionally, `FileStorage` class uses the `JsonHelper` class and its static methods to serialise/deserialise JSON objects.

`BridgeExample` initialises and contains both - customer and order - repositories which are used to retrieve the corresponding data. Additionally, the storage type of these repositories could be changed between the `FileStorage` and `SqlStorage` separately and at the run-time.

### EntityBase

An abstract class that stores the id field and is extended by all of the entity classes.

```dart
abstract class EntityBase {
  EntityBase() : id = faker.guid.guid();

  final String id;

  EntityBase.fromJson(Map<String, dynamic> json) : id = json['id'] as String;
}
```

### Customer

A simple class to store information about the customer: its name and email. Also, the constructor generates random values when initialising the Customer object.

```dart
class Customer extends EntityBase {
  Customer()
      : name = faker.person.name(),
        email = faker.internet.email();

  final String name;
  final String email;

  Customer.fromJson(super.json)
      : name = json['name'] as String,
        email = json['email'] as String,
        super.fromJson();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
      };
}
```

### Order

A simple class to store information about the order: a list of dishes it contains and the total price of the order. Also, the constructor generates random values when initialising the Order object.

```dart
class Order extends EntityBase {
  Order()
      : dishes = List.generate(
          random.integer(3, min: 1),
          (_) => faker.food.dish(),
        ),
        total = random.decimal(scale: 20, min: 5);

  final List<String> dishes;
  final double total;

  Order.fromJson(super.json)
      : dishes = List.from(json['dishes'] as List),
        total = json['total'] as double,
        super.fromJson();

  Map<String, dynamic> toJson() => {
        'id': id,
        'dishes': dishes,
        'total': total,
      };
}
```

### JsonHelper

A helper classes used by the `FileStorage` to serialise objects of type `EntityBase` to JSON objects and deserialize them from the JSON string.

```dart
class JsonHelper {
  const JsonHelper._();

  static String serialiseObject(EntityBase entityBase) {
    return jsonEncode(entityBase);
  }

  static T deserialiseObject<T extends EntityBase>(String jsonString) {
    final json = jsonDecode(jsonString)! as Map<String, dynamic>;

    return switch (T) {
      const (Customer) => Customer.fromJson(json) as T,
      const (Order) => Order.fromJson(json) as T,
      _ => throw Exception("Type of '$T' is not supported."),
    };
  }
}
```

### IRepository

An interface that defines methods to be implemented by the derived repository classes.

```dart
abstract interface class IRepository {
  List<EntityBase> getAll();
  void save(EntityBase entityBase);
}
```

### Concrete repositories

- `CustomersRepository` - a specific implementation of the `IRepository` interface to store customers' data.

```dart
class CustomersRepository implements IRepository {
  const CustomersRepository(this.storage);

  final IStorage storage;

  @override
  List<EntityBase> getAll() => storage.fetchAll<Customer>();

  @override
  void save(EntityBase entityBase) {
    storage.store<Customer>(entityBase as Customer);
  }
}
```

- `OrdersRepository` - a specific implementation of the `IRepository` interface to store orders' data.

```dart
class OrdersRepository implements IRepository {
  const OrdersRepository(this.storage);

  final IStorage storage;

  @override
  List<EntityBase> getAll() => storage.fetchAll<Order>();

  @override
  void save(EntityBase entityBase) {
    storage.store<Order>(entityBase as Order);
  }
}
```

### IStorage

An interface that defines methods to be implemented by the derived storage classes.

```dart
abstract interface class IStorage {
  String getTitle();
  List<T> fetchAll<T extends EntityBase>();
  void store<T extends EntityBase>(T entityBase);
}
```

### Concrete storages

- `FileStorage` - a specific implementation of the `IStorage` interface to store an object in the storage as a file - this behaviour is mocked by storing an object as a JSON string.

```dart
class FileStorage implements IStorage {
  final Map<Type, List<String>> fileStorage = {};

  @override
  String getTitle() => 'File Storage';

  @override
  List<T> fetchAll<T extends EntityBase>() {
    if (!fileStorage.containsKey(T)) return [];

    final files = fileStorage[T]!;

    return files.map<T>((f) => JsonHelper.deserialiseObject<T>(f)).toList();
  }

  @override
  void store<T extends EntityBase>(T entityBase) {
    if (!fileStorage.containsKey(T)) fileStorage[T] = [];

    fileStorage[T]!.add(JsonHelper.serialiseObject(entityBase));
  }
}
```

- `SqlStorage` - a specific implementation of the `IStorage` interface to store an object in the storage as an entity - this behaviour is mocked by using the Map data structure and appending entities of the same type to the list.

```dart
class SqlStorage implements IStorage {
  final Map<Type, List<EntityBase>> sqlStorage = {};

  @override
  String getTitle() => 'SQL Storage';

  @override
  List<T> fetchAll<T extends EntityBase>() =>
      sqlStorage.containsKey(T) ? sqlStorage[T]! as List<T> : [];

  @override
  void store<T extends EntityBase>(T entityBase) {
    if (!sqlStorage.containsKey(T)) sqlStorage[T] = <T>[];

    sqlStorage[T]!.add(entityBase);
  }
}
```

### Example

`BridgeExample` contains a list of storages - instances of `SqlStorage` and `FileStorage` classes. Also, it initialises `Customer` and `Order` repositories. In the repositories the concrete type of storage could be interchanged by triggering the `onSelectedCustomerStorageIndexChanged()` for the `CustomersRepository` and `onSelectedOrderStorageIndexChanged()` for the `OrdersRepository` respectively.

The concrete repository does not care about the specific type of storage it uses as long as the storage implements the IStorage interface and all of its methods. As a result, the abstraction (repository) is separated from the implementor (storage) - the concrete implementation of the storage could be changed for the repository at run-time, the repository does not depend on its implementation details.

```dart
class BridgeExample extends StatefulWidget {
  const BridgeExample();

  @override
  _BridgeExampleState createState() => _BridgeExampleState();
}

class _BridgeExampleState extends State<BridgeExample> {
  final _storages = [SqlStorage(), FileStorage()];

  late IRepository _customersRepository;
  late IRepository _ordersRepository;

  late List<Customer> _customers;
  late List<Order> _orders;

  var _selectedCustomerStorageIndex = 0;
  var _selectedOrderStorageIndex = 0;

  void _onSelectedCustomerStorageIndexChanged(int? index) {
    if (index == null) return;

    setState(() {
      _selectedCustomerStorageIndex = index;
      _customersRepository = CustomersRepository(_storages[index]);
      _customers = _customersRepository.getAll() as List<Customer>;
    });
  }

  void _onSelectedOrderStorageIndexChanged(int? index) {
    if (index == null) return;

    setState(() {
      _selectedOrderStorageIndex = index;
      _ordersRepository = OrdersRepository(_storages[index]);
      _orders = _ordersRepository.getAll() as List<Order>;
    });
  }

  void _addCustomer() {
    _customersRepository.save(Customer());

    setState(
      () => _customers = _customersRepository.getAll() as List<Customer>,
    );
  }

  void _addOrder() {
    _ordersRepository.save(Order());

    setState(() => _orders = _ordersRepository.getAll() as List<Order>);
  }

  @override
  void initState() {
    super.initState();

    _customersRepository =
        CustomersRepository(_storages[_selectedCustomerStorageIndex]);
    _customers = _customersRepository.getAll() as List<Customer>;

    _ordersRepository = OrdersRepository(_storages[_selectedOrderStorageIndex]);
    _orders = _ordersRepository.getAll() as List<Order>;
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Select customers storage:',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            StorageSelection(
              storages: _storages,
              selectedIndex: _selectedCustomerStorageIndex,
              onChanged: _onSelectedCustomerStorageIndexChanged,
            ),
            PlatformButton(
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _addCustomer,
              text: 'Add',
            ),
            if (_customers.isNotEmpty)
              CustomersDatatable(customers: _customers)
            else
              Text(
                '0 customers found',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            const Divider(),
            Row(
              children: <Widget>[
                Text(
                  'Select orders storage:',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            StorageSelection(
              storages: _storages,
              selectedIndex: _selectedOrderStorageIndex,
              onChanged: _onSelectedOrderStorageIndexChanged,
            ),
            PlatformButton(
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _addOrder,
              text: 'Add',
            ),
            if (_orders.isNotEmpty)
              OrdersDatatable(orders: _orders)
            else
              Text(
                '0 orders found',
                style: Theme.of(context).textTheme.titleSmall,
              ),
          ],
        ),
      ),
    );
  }
}
```
