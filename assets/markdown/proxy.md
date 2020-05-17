## Class diagram

![Proxy Class Diagram](resource:assets/images/proxy/proxy.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of the **Proxy** design pattern.

![Proxy Implementation Class Diagram](resource:assets/images/proxy/proxy_implementation.png)

_Customer_ class is used to store information about the customer. One of its properties is the _CustomerDetails_ which stores additional data about the customer e.g. its email, hobby and position.

_ICustomerDetailsService_ is an abstract class which is used as an interface for the customer details service:

- _getCustomerDetails()_ - an abstract method which returns details for the specific customer.

_CustomerDetailsService_ is the "real" customer details service which implements the abstract class _ICustomerDetailsService_ and its methods.

_CustomerDetailsServiceProxy_ is a proxy service which contains the cache (dictionary object) and sends the request to the real _CustomerDetailsService_ only if the customer details object is not available in the cache.

_ProxyExample_ initialises and contains the proxy object of the real customer details service. When a user selects the option to see more details about the customer, the dialog window appears and loads details about the customer. If the details object is already stored inside the cache, the proxy service returns that object instantly. Otherwise, a request is sent to the real customer details service and the details object is returned from there.

### Customer

A simple class to store information about the customer: its id, name and details. Also, the constructor generates random id and name values when initialising the Customer object.

```
class Customer {
  String id;
  String name;
  CustomerDetails details;

  Customer() {
    id = faker.guid.guid();
    name = faker.person.name();
  }
}
```

### CustomerDetails

A simple class to store information about customer details: id to map the details information with the corresponding customer, e-mail address, hobby and the current position (job title).

```
class CustomerDetails {
  final String customerId;
  final String email;
  final String hobby;
  final String position;

  const CustomerDetails(
    this.customerId,
    this.email,
    this.hobby,
    this.position,
  );
}
```

### ICustomerDetailsService

An interface which defines the _getCustomerDetails()_ method to be implemented by the customer details service and its proxy. Dart language does not support the interface as a class type, so we define an interface by creating an abstract class and providing a method header (name, return type, parameters) without the default implementation.

```
abstract class ICustomerDetailsService {
  Future<CustomerDetails> getCustomerDetails(String id);
}
```

### CustomerDetailsService

A specific implementation of the _ICustomerDetailsService_ interface - the real customer details service. The _getCustomerDetails()_ method mocks the real behaviour of the service and generates random values of customer details.

```
class CustomerDetailsService implements ICustomerDetailsService {
  @override
  Future<CustomerDetails> getCustomerDetails(String id) async {
    return Future.delayed(
      const Duration(seconds: 2),
      () {
        var email = faker.internet.email();
        var hobby = faker.sport.name();
        var position = faker.job.title();

        return CustomerDetails(id, email, hobby, position);
      },
    );
  }
}
```

### CustomerDetailsServiceProxy

A specific implementation of the _ICustomerDetailsService_ interface - a proxy for the real customer details service. Before making a call to the customer details service, the proxy service checks whether the customer details are already fetched and saved in the cache. If yes, the customer details object is returned from the cache, otherwise, a request is sent to the real customer service and its value is saved to the cache and returned.

```
class CustomerDetailsServiceProxy implements ICustomerDetailsService {
  final ICustomerDetailsService service;
  final Map<String, CustomerDetails> customerDetailsCache =
      Map<String, CustomerDetails>();

  CustomerDetailsServiceProxy(this.service);

  @override
  Future<CustomerDetails> getCustomerDetails(String id) async {
    if (customerDetailsCache.containsKey(id)) {
      return customerDetailsCache[id];
    }

    var customerDetails = await service.getCustomerDetails(id);
    customerDetailsCache[id] = customerDetails;

    return customerDetails;
  }
}
```

### Example

_ProxyExample_ contains the proxy object of the real customer details service. When the user wants to see customer details, the _showDialog()_ method is triggered (via the _showCustomerDetails()_ method) which opens the dialog window of type _CustomerDetailsDialog_ and passes the proxy object via its constructor as well as the selected customer's information - the _Customer_ object.

```
class ProxyExample extends StatefulWidget {
  @override
  _ProxyExampleState createState() => _ProxyExampleState();
}

class _ProxyExampleState extends State<ProxyExample> {
  final ICustomerDetailsService _customerDetailsServiceProxy =
      CustomerDetailsServiceProxy(CustomerDetailsService());
  final List<Customer> _customerList = List.generate(10, (_) => Customer());

  void _showCustomerDetails(Customer customer) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext _) {
        return CustomerDetailsDialog(
          service: _customerDetailsServiceProxy,
          customer: customer,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: paddingL),
        child: Column(
          children: <Widget>[
            Text(
              'Press on the list tile to see more information about the customer',
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: spaceL),
            for (var customer in _customerList)
              Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Text(
                      customer.name[0],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  trailing: Icon(Icons.info_outline),
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

The _CustomerDetailsDialog_ class uses the passed proxy service on its state's initialisation, hence loading details of the selected customer.

```
class CustomerDetailsDialog extends StatefulWidget {
  final Customer customer;
  final ICustomerDetailsService service;

  const CustomerDetailsDialog({
    @required this.customer,
    @required this.service,
  })  : assert(customer != null),
        assert(service != null);

  @override
  _CustomerDetailsDialogState createState() => _CustomerDetailsDialogState();
}

class _CustomerDetailsDialogState extends State<CustomerDetailsDialog> {
  @override
  void initState() {
    super.initState();

    widget.service
        .getCustomerDetails(widget.customer.id)
        .then((CustomerDetails customerDetails) => setState(() {
              widget.customer.details = customerDetails;
            }));
  }

  void _closeDialog() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.customer.name),
      content: Container(
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
                customerDetails: widget.customer.details,
              ),
      ),
      actions: <Widget>[
        PlatformButton(
          child: Text('Close'),
          materialColor: Colors.black,
          materialTextColor: Colors.white,
          onPressed: _closeDialog,
        ),
      ],
    );
  }
}
```

The _CustomerDetailsDialog_ class does not care about the specific type of customer details service as long as it implements the _ICustomerDetailsService_ interface. As a result, an additional caching layer could be used by sending the request through the proxy service, hence improving the general performance of the application, possibly saving some additional network data and reducing the number of requests sent to the real customer details service as well. Also, if you want to call the real customer details service directly, you can just simply pass it via the _CustomerDetailsDialog_ constructor - no additional changes are needed in the UI code since both the real service and its proxy implements the same interface.
