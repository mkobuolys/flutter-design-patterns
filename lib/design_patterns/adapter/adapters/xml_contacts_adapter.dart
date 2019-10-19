import 'package:xml/xml.dart' as xml;

import 'package:flutter_design_patterns/design_patterns/adapter/apis/xml_contacts_api.dart';
import 'package:flutter_design_patterns/design_patterns/adapter/contact.dart';
import 'package:flutter_design_patterns/design_patterns/adapter/icontacts_accessor.dart';

class XmlContactsAdapter implements IContactsAccessor {
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
