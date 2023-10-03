## Class diagram

![Proxy Class Diagram](resource:assets/images/proxy/proxy.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of the **Proxy** design pattern.

![Proxy Implementation Class Diagram](resource:assets/images/proxy/proxy_implementation.png)

`Customer` class is used to store information about the customer. One of its properties is the `CustomerDetails` which stores additional data about the customer e.g. its email, hobby and position.

`ICustomerDetailsService` defines an interface for the customer details service:

- `getCustomerDetails()` - returns details for the specific customer.

`CustomerDetailsService` is the "real" customer details service that implements the `ICustomerDetailsService` interface.

`CustomerDetailsServiceProxy` is a proxy service which contains the cache (dictionary object) and sends the request to the real `CustomerDetailsService` only if the customer details object is not available in the cache.

`ProxyExample` initialises and contains the proxy object of the real customer details service. When a user selects the option to see more details about the customer, the dialog window appears and loads details about the customer. If the details object is already stored inside the cache, the proxy service returns that object instantly. Otherwise, a request is sent to the real customer details service and the details object is returned from there.

### Customer

A simple class to store information about the customer: its id, name and details. Also, the constructor generates random id and name values when initialising the Customer object.

```dart
class Customer {
  Customer()
      : id = faker.guid.guid(),
        name = faker.person.name();

  final String id;
  final String name;
  CustomerDetails? details;
}
```

### CustomerDetails

A simple class to store information about customer details: id to map the details information with the corresponding customer, e-mail address, hobby and the current position (job title).

```dart
class CustomerDetails {
  const CustomerDetails({
    required this.customerId,
    required this.email,
    required this.hobby,
    required this.position,
  });

  final String customerId;
  final String email;
  final String hobby;
  final String position;
}
```

### ICustomerDetailsService

An interface that defines the `getCustomerDetails()` method to be implemented by the customer details service and its proxy.

```dart
abstract interface class ICustomerDetailsService {
  Future<CustomerDetails> getCustomerDetails(String id);
}
```

### CustomerDetailsService

A specific implementation of the `ICustomerDetailsService` interface - the real customer details service. The `getCustomerDetails()` method mocks the real behaviour of the service and generates random values of customer details.

```dart
class CustomerDetailsService implements ICustomerDetailsService {
  const CustomerDetailsService();

  @override
  Future<CustomerDetails> getCustomerDetails(String id) => Future.delayed(
        const Duration(seconds: 2),
        () => CustomerDetails(
          customerId: id,
          email: faker.internet.email(),
          hobby: faker.sport.name(),
          position: faker.job.title(),
        ),
      );
}
```

### CustomerDetailsServiceProxy

A specific implementation of the `ICustomerDetailsService` interface - a proxy for the real customer details service. Before making a call to the customer details service, the proxy service checks whether the customer details are already fetched and saved in the cache. If yes, the customer details object is returned from the cache, otherwise, a request is sent to the real customer service and its value is saved to the cache and returned.

```dart
class CustomerDetailsServiceProxy implements ICustomerDetailsService {
  CustomerDetailsServiceProxy(this.service);

  final ICustomerDetailsService service;
  final Map<String, CustomerDetails> customerDetailsCache = {};

  @override
  Future<CustomerDetails> getCustomerDetails(String id) async {
    if (customerDetailsCache.containsKey(id)) return customerDetailsCache[id]!;

    final customerDetails = await service.getCustomerDetails(id);
    customerDetailsCache[id] = customerDetails;

    return customerDetails;
  }
}
```

### Example

`ProxyExample` contains the proxy object of the real customer details service. When the user wants to see customer details, the `showDialog()` method is triggered (via the `showCustomerDetails()` method) which opens the dialog window of type `CustomerDetailsDialog` and passes the proxy object via its constructor as well as the selected customer's information - the `Customer` object.

```dart
class ProxyExample extends StatefulWidget {
  const ProxyExample();

  @override
  _ProxyExampleState createState() => _ProxyExampleState();
}

class _ProxyExampleState extends State<ProxyExample> {
  final _customerDetailsServiceProxy = CustomerDetailsServiceProxy(
    const CustomerDetailsService(),
  );
  final _customerList = List.generate(10, (_) => Customer());

  void _showCustomerDetails(Customer customer) => showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => CustomerDetailsDialog(
          service: _customerDetailsServiceProxy,
          customer: customer,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: LayoutConstants.paddingL,
        ),
        child: Column(
          children: <Widget>[
            Text(
              'Press on the list tile to see more information about the customer',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: LayoutConstants.spaceL),
            for (final customer in _customerList)
              Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Text(
                      customer.name[0],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  trailing: const Icon(Icons.info_outline),
                  title: Text(customer.name),
                  onTap: () => _showCustomerDetails(customer),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
```

The `CustomerDetailsDialog` class uses the passed proxy service on its state's initialisation, hence loading details of the selected customer.

```dart
class CustomerDetailsDialog extends StatefulWidget {
  const CustomerDetailsDialog({
    required this.customer,
    required this.service,
  });

  final Customer customer;
  final ICustomerDetailsService service;

  @override
  _CustomerDetailsDialogState createState() => _CustomerDetailsDialogState();
}

class _CustomerDetailsDialogState extends State<CustomerDetailsDialog> {
  @override
  void initState() {
    super.initState();

    widget.service.getCustomerDetails(widget.customer.id).then(
          (CustomerDetails customerDetails) => setState(() {
            widget.customer.details = customerDetails;
          }),
        );
  }

  void _closeDialog() => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.customer.name),
      content: SizedBox(
        height: 200.0,
        child: widget.customer.details == null
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: lightBackgroundColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.black.withOpacity(0.65),
                  ),
                ),
              )
            : CustomerDetailsColumn(
                customerDetails: widget.customer.details!,
              ),
      ),
      actions: <Widget>[
        Visibility(
          visible: widget.customer.details != null,
          child: PlatformButton(
            materialColor: Colors.black,
            materialTextColor: Colors.white,
            onPressed: _closeDialog,
            text: 'Close',
          ),
        ),
      ],
    );
  }
}
```

The `CustomerDetailsDialog` class does not care about the specific type of customer details service as long as it implements the `ICustomerDetailsService` interface. As a result, an additional caching layer could be used by sending the request through the proxy service, hence improving the general performance of the application, possibly saving some additional network data and reducing the number of requests sent to the real customer details service as well. Also, if you want to call the real customer details service directly, you can just simply pass it via the _CustomerDetailsDialog_ constructor - no additional changes are needed in the UI code since both the real service and its proxy implements the same interface.
