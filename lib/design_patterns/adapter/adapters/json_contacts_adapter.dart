import 'dart:convert';

import 'package:flutter_design_patterns/design_patterns/adapter/apis/json_contacts_api.dart';
import 'package:flutter_design_patterns/design_patterns/adapter/contact.dart';
import 'package:flutter_design_patterns/design_patterns/adapter/icontacts_adapter.dart';

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
