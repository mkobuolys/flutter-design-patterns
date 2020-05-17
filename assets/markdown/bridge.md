## Class diagram

![Bridge Class Diagram](resource:assets/images/bridge/bridge.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of the **Bridge** design pattern.

![Bridge Implementation Class Diagram](resource:assets/images/bridge/bridge_implementation.png)

The _EntityBase_ is an abstract class which is used as a base class for all the entity classes. The class contains an _id_ property and a named constructor _EntityBase.fromJson_ to map the JSON object to the class field.

_Customer_ and _Order_ are concrete entities which extend the abstract class _EntityBase_. _Customer_ class contains _name_ and _email_ properties, _Customer.fromJson_ named constructor to map the JSON object to class fields and a _toJson()_ method to map class fields to the corresponding JSON map object. _Order_ class contain _dishes_ (a list of dishes of that order) and _total_ fields, a named constructor _Order.fromJson_ and a _toJson()_ method respectively.

_IRepository_ is an abstract class which is used as an interface for the repositories:

- _getAll()_ - returns all records from the repository;
- _save()_ - saves an entity of type _EntityBase_ in the repository.

_CustomersRepository_ and _OrdersRepository_ are concrete repository classes which extend the abstract class _IRepository_ and implement its abstract methods. Also, these classes contain a storage property of type _IStorage_ which is injected into the repository via the constructor.

_IStorage_ is an abstract class which is used as an interface for the storages:

- _getTitle()_ - returns the title of the storage. The method is used in UI;
- _fetchAll\<T\>()_ - returns all the records of type _T_ from the storage;
- _store\<T\>()_ - stores a record of type _T_ in the storage.

_FileStorage_ and _SqlStorage_ are concrete storage classes which extend the abstract class _IStorage_ and implement its abstract methods. Additionally, _FileStorage_ class uses the _JsonHelper_ class and its static methods to serialise/deserialise JSON objects.

_BridgeExample_ initialises and contains both - customer and order - repositories which are used to retrieve the corresponding data. Additionally, the storage type of these repositories could be changed between the _FileStorage_ and _SqlStorage_ separately and at the run-time.

### EntityBase

An abstract class which stores the id field and is extended by all of the entity classes.

```
abstract class EntityBase {
  String id;

  EntityBase() {
    id = faker.guid.guid();
  }

  EntityBase.fromJson(Map<String, dynamic> json) : id = json['id'];
}
```

### Customer

A simple class to store information about the customer: its name and email. Also, the constructor generates random values when initialising the Customer object.

```
class Customer extends EntityBase {
  String name;
  String email;

  Customer() : super() {
    name = faker.person.name();
    email = faker.internet.email();
  }

  Customer.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        super.fromJson(json);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
      };
}
```

### Order

A simple class to store information about the order: a list of dishes it contains and the total price of the order. Also, the constructor generates random values when initialising the Order object.

```
class Order extends EntityBase {
  List<String> dishes;
  double total;

  Order() : super() {
    dishes = List.generate(random.integer(3, min: 1), (_) => faker.food.dish());
    total = random.decimal(scale: 20, min: 5);
  }

  Order.fromJson(Map<String, dynamic> json)
      : dishes = List.from(json['dishes']),
        total = json['total'],
        super.fromJson(json);

  Map<String, dynamic> toJson() => {
        'id': id,
        'dishes': dishes,
        'total': total,
      };
}
```

### JsonHelper

A helper classes used by the _FileStorage_ to serialise objects of type _EntityBase_ to JSON objects and deserialise them from the JSON string.

```
class JsonHelper {
  static String serialiseObject(EntityBase entityBase) {
    return jsonEncode(entityBase);
  }

  static EntityBase deserialiseObject<T extends EntityBase>(String jsonString) {
    var json = jsonDecode(jsonString);

    switch (T) {
      case Customer:
        return Customer.fromJson(json);
      case Order:
        return Order.fromJson(json);
      default:
        throw Exception("Type of '$T' is not supported.");
    }
  }
}
```

### IRepository

An interface which defines methods to be implemented by the derived repository classes. Dart language does not support the interface as a class type, so we define an interface by creating an abstract class and providing a method header (name, return type, parameters) without the default implementation.

```
abstract class IRepository {
  List<EntityBase> getAll();
  void save(EntityBase entityBase);
}
```

### Concrete repositories

- _CustomersRepository_ - a specific implementation of the _IRepository_ interface to store customers' data.

```
class CustomersRepository implements IRepository {
  final IStorage storage;

  const CustomersRepository(this.storage);

  @override
  List<EntityBase> getAll() {
    return storage.fetchAll<Customer>();
  }

  @override
  void save(EntityBase entityBase) {
    storage.store<Customer>(entityBase);
  }
}
```

- _OrdersRepository_ - a specific implementation of the _IRepository_ interface to store orders' data.

```
class OrdersRepository implements IRepository {
  final IStorage storage;

  const OrdersRepository(this.storage);

  @override
  List<EntityBase> getAll() {
    return storage.fetchAll<Order>();
  }

  @override
  void save(EntityBase entityBase) {
    storage.store<Order>(entityBase);
  }
}
```

### IStorage

An interface which defines methods to be implemented by the derived storage classes.

```
abstract class IStorage {
  String getTitle();
  List<T> fetchAll<T extends EntityBase>();
  void store<T extends EntityBase>(T entityBase);
}
```

### Concrete storages

- _FileStorage_ - a specific implementation of the _IStorage_ interface to store an object in the storage as a file - this behaviour is mocked by storing an object as a JSON string.

```
class FileStorage implements IStorage {
  Map<Type, List<String>> fileStorage = Map<Type, List<String>>();

  @override
  String getTitle() {
    return 'File Storage';
  }

  @override
  List<T> fetchAll<T extends EntityBase>() {
    if (fileStorage.containsKey(T)) {
      var files = fileStorage[T];

      return files.map<T>((f) => JsonHelper.deserialiseObject<T>(f)).toList();
    }

    return List<T>();
  }

  @override
  void store<T extends EntityBase>(T entityBase) {
    if (!fileStorage.containsKey(T)) {
      fileStorage[T] = List<String>();
    }

    fileStorage[T].add(JsonHelper.serialiseObject(entityBase));
  }
}
```

- _SqlStorage_ - a specific implementation of the _IStorage_ interface to store an object in the storage as an entity - this behaviour is mocked by using the Map data structure and appending entities of the same type to the list.

```
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
```

### Example

_BridgeExample_ contains a list of storages - instances of _SqlStorage_ and _FileStorage_ classes. Also, it initialises _Customer_ and _Order_ repositories. In the repositories the concrete type of storage could be interchanged by triggering the _onSelectedCustomerStorageIndexChanged()_ for the _CustomersRepository_ and _onSelectedOrderStorageIndexChanged()_ for the _OrdersRepository_ respectively.

The concrete repository does not care about the specific type of storage it uses as long as the storage implements the IStorage interface and all of its abstract methods. As a result, the abstraction (repository) is separated from the implementor (storage) - the concrete implementation of the storage could be changed for the repository at run-time, the repository does not depend on its implementation details.

```
class BridgeExample extends StatefulWidget {
  @override
  _BridgeExampleState createState() => _BridgeExampleState();
}

class _BridgeExampleState extends State<BridgeExample> {
  final List<IStorage> _storages = [SqlStorage(), FileStorage()];

  IRepository _customersRepository;
  IRepository _ordersRepository;

  List<Customer> _customers;
  List<Order> _orders;

  int _selectedCustomerStorageIndex = 0;
  int _selectedOrderStorageIndex = 0;

  void _onSelectedCustomerStorageIndexChanged(int index) {
    setState(() {
      _selectedCustomerStorageIndex = index;
      _customersRepository = CustomersRepository(_storages[index]);
      _customers = _customersRepository.getAll();
    });
  }

  void _onSelectedOrderStorageIndexChanged(int index) {
    setState(() {
      _selectedOrderStorageIndex = index;
      _ordersRepository = OrdersRepository(_storages[index]);
      _orders = _ordersRepository.getAll();
    });
  }

  void _addCustomer() {
    _customersRepository.save(Customer());

    setState(() {
      _customers = _customersRepository.getAll();
    });
  }

  void _addOrder() {
    _ordersRepository.save(Order());

    setState(() {
      _orders = _ordersRepository.getAll();
    });
  }

  @override
  void initState() {
    super.initState();

    _customersRepository =
        CustomersRepository(_storages[_selectedCustomerStorageIndex]);
    _customers = _customersRepository.getAll();

    _ordersRepository = OrdersRepository(_storages[_selectedOrderStorageIndex]);
    _orders = _ordersRepository.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Select customers storage:',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
            StorageSelection(
              storages: _storages,
              selectedIndex: _selectedCustomerStorageIndex,
              onChanged: _onSelectedCustomerStorageIndexChanged,
            ),
            PlatformButton(
              child: Text('Add'),
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _addCustomer,
            ),
            _customers.isNotEmpty
                ? CustomersDatatable(customers: _customers)
                : Text(
                    '0 customers found',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
            Divider(),
            Row(
              children: <Widget>[
                Text(
                  'Select orders storage:',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
            StorageSelection(
              storages: _storages,
              selectedIndex: _selectedOrderStorageIndex,
              onChanged: _onSelectedOrderStorageIndexChanged,
            ),
            PlatformButton(
              child: Text('Add'),
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _addOrder,
            ),
            _orders.isNotEmpty
                ? OrdersDatatable(orders: _orders)
                : Text(
                    '0 orders found',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
          ],
        ),
      ),
    );
  }
}
```
