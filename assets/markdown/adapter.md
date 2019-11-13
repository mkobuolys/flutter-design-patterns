## Class diagram

![Adapter Class Diagram](resource:assets/images/adapter/adapter.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of Adapter design pattern using **object adapter** method.

![Adapter Implementation Class Diagram](resource:assets/images/adapter/adapter_implementation.png)

First of all, there are two APIs: _JsonContactsApi_ and _XmlContactsApi_. These two APIs have different methods to return contacts information in two different formats - JSON and XML. Hence, two different adapters should be created to convert the specific contacts' representation to the required format which is needed in the _ContactsSection_ component (widget) - list of _Contact_ objects. To unify the contract (interface) of adapters, _IContactsAdapter_ abstract class is created which requires to implement (override) the _getContacts()_ method in all the implementations of this abstract class. _JsonContactsAdapter_ implements the _IContactsAdapter_, uses the _JsonContactsApi_ to retrieve contacts information as a JSON string, then parses it to a list of _Contact_ objects and returns it via _getContacts()_ method. Accordingly, _XmlContactsAdapter_ is implemented in the same manner, but it receives the data from _XmlContactsApi_ in XML format.

### Contact

A simple class to store the contact's information.

```
class Contact {
  final String fullName;
  final String email;
  final bool favourite;

  const Contact({
    this.fullName,
    this.email,
    this.favourite,
  });
}
```

### JsonContactsApi

A fake API which returns contacts' information as JSON string.

```
class JsonContactsApi {
  final String _contactsJson = '''
  {
    "contacts": [
      {
        "fullName": "John Doe (JSON)",
        "email": "johndoe@json.com",
        "favourite": true
      },
      {
        "fullName": "Emma Doe (JSON)",
        "email": "emmadoe@json.com",
        "favourite": false
      },
      {
        "fullName": "Michael Roe (JSON)",
        "email": "michaelroe@json.com",
        "favourite": false
      }
    ]
  }
  ''';

  String getContactsJson() {
    return _contactsJson;
  }
}
```

### XmlContactsApi

A fake API which returns contacts' information as XML string.

```
class XmlContactsApi {
  final String _contactsXml = '''
  <?xml version="1.0"?>
  <contacts>
    <contact>
      <fullname>John Doe (XML)</fullname>
      <email>johndoe@xml.com</email>
      <favourite>false</favourite>
    </contact>
    <contact>
      <fullname>Emma Doe (XML)</fullname>
      <email>emmadoe@xml.com</email>
      <favourite>true</favourite>
    </contact>
    <contact>
      <fullname>Michael Roe (XML)</fullname>
      <email>michaelroe@xml.com</email>
      <favourite>true</favourite>
    </contact>
  </contacts>
  ''';

  String getContactsXml() {
    return _contactsXml;
  }
}
```

### IContactsAdapter

A contract (interface) which unifies adapters and requires them to implement the method _getContacts()_. Dart language does not support interface as a class type, so we define an interface by creating an abstract class and providing a method header (name, return type, parameters) without the default implementation.

```
abstract class IContactsAdapter {
  List<Contact> getContacts();
}
```

### JsonContactsAdapter

An adapter, which implements the _getContacts()_ method. Inside the method, contacts' information is retrieved from _JsonContactsApi_ and parsed to the required return type.

```
class JsonContactsAdapter implements IContactsAdapter {
  final JsonContactsApi _api = JsonContactsApi();

  @override
  List<Contact> getContacts() {
    var contactsJson = _api.getContactsJson();
    var contactsList = _parseContactsJson(contactsJson);

    return contactsList;
  }

  List<Contact> _parseContactsJson(String contactsJson) {
    var contactsMap = json.decode(contactsJson) as Map<String, dynamic>;
    var contactsJsonList = contactsMap['contacts'] as List;
    var contactsList = contactsJsonList
        .map((json) => Contact(
              fullName: json['fullName'],
              email: json['email'],
              favourite: json['favourite'],
            ))
        .toList();

    return contactsList;
  }
}
```

### XmlContactsAdapter

An adapter, which implements the _getContacts()_ method. Inside the method, contacts' information is retrieved from _XmlContactsApi_ and parsed to the required return type.

```
class XmlContactsAdapter implements IContactsAdapter {
  final XmlContactsApi _api = XmlContactsApi();

  @override
  List<Contact> getContacts() {
    var contactsXml = _api.getContactsXml();
    var contactsList = _parseContactsXml(contactsXml);

    return contactsList;
  }

  List<Contact> _parseContactsXml(String contactsXml) {
    var xmlDocument = xml.parse(contactsXml);
    var contactsList = List<Contact>();

    for (var xmlElement in xmlDocument.findAllElements('contact')) {
      var fullName = xmlElement.findElements('fullname').single.text;
      var email = xmlElement.findElements('email').single.text;
      var favouriteString = xmlElement.findElements('favourite').single.text;
      var favourite = favouriteString.toLowerCase() == 'true';

      contactsList.add(Contact(
        fullName: fullName,
        email: email,
        favourite: favourite,
      ));
    }

    return contactsList;
  }
}
```

### Example

- AdapterExample - implements the example widget. This widget uses _ContactsSection_ component which requires a specific adapter of type _IContactsAdapter_ to be injected via constructor.

```
class AdapterExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ContactsSection(
              adapter: JsonContactsAdapter(),
              headerText: 'Contacts from JSON API:',
            ),
            const SizedBox(height: spaceL),
            ContactsSection(
              adapter: XmlContactsAdapter(),
              headerText: 'Contacts from XML API:',
            ),
          ],
        ),
      ),
    );
  }
}
```

- ContactsSection - uses the injected adapter of type _IContactsAdapter_. The widget only cares about the adapter's type, but not its specific implementation. Hence, we can provide different adapters of type _IContactsAdapter_ which load the contacts' information from different data sources without making any changes to the UI.

```
class ContactsSection extends StatefulWidget {
  final IContactsAdapter adapter;
  final String headerText;

  const ContactsSection({
    @required this.adapter,
    @required this.headerText,
  })  : assert(adapter != null),
        assert(headerText != null);

  _ContactsSectionState createState() => _ContactsSectionState();
}

class _ContactsSectionState extends State<ContactsSection> {
  final List<Contact> contacts = List<Contact>();

  void _getContacts() {
    setState(() {
      contacts.addAll(widget.adapter.getContacts());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
	    ...
    );
  }
}
```
