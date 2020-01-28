## Class diagram

![Proxy Class Diagram](resource:assets/images/proxy/proxy.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of the **Proxy** design pattern.

![Proxy Implementation Class Diagram](resource:assets/images/proxy/proxy_implementation.png)

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

```
abstract class ICustomerDetailsService {
  Future<CustomerDetails> getCustomerDetails(String id);
}
```

### CustomerDetailsService

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
              style: Theme.of(context).textTheme.subhead,
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
