## Class diagram

![Adapter Class Diagram](resource:assets/images/adapter/adapter.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of Adapter design pattern using **object adapter** method.

![Adapter Implementation Class Diagram](resource:assets/images/adapter/adapter_implementation.png)

First of all, there are two APIs: `JsonContactsApi` and `XmlContactsApi`. These two APIs have different methods to return contacts information in two different formats — JSON and XML. Hence, two different adapters should be created to convert the specific contacts’ representation to the required format which is needed in the `ContactsSection` component (widget) — list of `Contact` objects. To unify the contract (interface) of adapters, `IContactsAdapter` abstract interface class is created which requires implementing the `getContacts()` method in all the implementations of this interface. `JsonContactsAdapter` implements the `IContactsAdapter`, uses the `JsonContactsApi` to retrieve contacts information as a JSON string, then parses it to a list of `Contact` objects and returns it via `getContacts()` method. Accordingly, `XmlContactsAdapter` is implemented in the same manner, but it receives the data from `XmlContactsApi` in XML format.

### Contact

A simple class to store the contact's information.

```dart
class Contact {
  final String fullName;
  final String email;
  final bool favourite;

  const Contact({
    required this.fullName,
    required this.email,
    required this.favourite,
  });
}
```

### JsonContactsApi

A fake API which returns contacts' information as JSON string.

```dart
class JsonContactsApi {
  static const _contactsJson = '''
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

  const JsonContactsApi();

  String getContactsJson() => _contactsJson;
}
```

### XmlContactsApi

A fake API which returns contacts' information as XML string.

```dart
class XmlContactsApi {
  static const _contactsXml = '''
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

  const XmlContactsApi();

  String getContactsXml() => _contactsXml;
}
```

### IContactsAdapter

A contract (interface) which unifies adapters and requires them to implement the method `getContacts()`.

```dart
abstract interface class IContactsAdapter {
  List<Contact> getContacts();
}
```

### JsonContactsAdapter

An adapter, which implements the `getContacts()` method. Inside the method, contacts' information is retrieved from `JsonContactsApi` and parsed to the required return type.

```dart
class JsonContactsAdapter implements IContactsAdapter {
  const JsonContactsAdapter({
    this.api = const JsonContactsApi(),
  });

  final JsonContactsApi api;

  @override
  List<Contact> getContacts() {
    final contactsJson = api.getContactsJson();
    final contactsList = _parseContactsJson(contactsJson);

    return contactsList;
  }

  List<Contact> _parseContactsJson(String contactsJson) {
    final contactsMap = json.decode(contactsJson) as Map<String, dynamic>;
    final contactsJsonList = contactsMap['contacts'] as List;
    final contactsList = contactsJsonList.map((json) {
      final contactJson = json as Map<String, dynamic>;

      return Contact(
        fullName: contactJson['fullName'] as String,
        email: contactJson['email'] as String,
        favourite: contactJson['favourite'] as bool,
      );
    }).toList();

    return contactsList;
  }
}
```

### XmlContactsAdapter

An adapter, which implements the `getContacts()` method. Inside the method, contacts' information is retrieved from `XmlContactsApi` and parsed to the required return type.

```dart
class XmlContactsAdapter implements IContactsAdapter {
  const XmlContactsAdapter({
    this.api = const XmlContactsApi(),
  });

  final XmlContactsApi api;

  @override
  List<Contact> getContacts() {
    final contactsXml = api.getContactsXml();
    final contactsList = _parseContactsXml(contactsXml);

    return contactsList;
  }

  List<Contact> _parseContactsXml(String contactsXml) {
    final xmlDocument = XmlDocument.parse(contactsXml);
    final contactsList = <Contact>[];

    for (final xmlElement in xmlDocument.findAllElements('contact')) {
      final fullName = xmlElement.findElements('fullname').single.innerText;
      final email = xmlElement.findElements('email').single.innerText;
      final favouriteString =
          xmlElement.findElements('favourite').single.innerText;
      final favourite = favouriteString.toLowerCase() == 'true';

      contactsList.add(
        Contact(
          fullName: fullName,
          email: email,
          favourite: favourite,
        ),
      );
    }

    return contactsList;
  }
}
```

### Example

- AdapterExample - implements the example widget. This widget uses `ContactsSection` component which requires a specific adapter of type `IContactsAdapter` to be injected via constructor.

```dart
class AdapterExample extends StatelessWidget {
  const AdapterExample();

  @override
  Widget build(BuildContext context) {
    return const ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: LayoutConstants.paddingL,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ContactsSection(
              adapter: JsonContactsAdapter(),
              headerText: 'Contacts from JSON API:',
            ),
            SizedBox(height: LayoutConstants.spaceL),
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

- ContactsSection - uses the injected adapter of type `IContactsAdapter`. The widget only cares about the adapter's type, but not its specific implementation. Hence, we can provide different adapters of type `IContactsAdapter` which load the contacts' information from different data sources without making any changes to the UI.

```dart
class ContactsSection extends StatefulWidget {
  final IContactsAdapter adapter;
  final String headerText;

  const ContactsSection({
    required this.adapter,
    required this.headerText,
  });

  @override
  _ContactsSectionState createState() => _ContactsSectionState();
}

class _ContactsSectionState extends State<ContactsSection> {
  final List<Contact> contacts = [];

  void _getContacts() {
    setState(() {
      contacts.addAll(widget.adapter.getContacts());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
	   // ...
    );
  }
}
```
