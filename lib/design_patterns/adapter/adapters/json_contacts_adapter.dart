import 'dart:convert';

import 'package:flutter_design_patterns/design_patterns/adapter/apis/json_contacts_api.dart';
import 'package:flutter_design_patterns/design_patterns/adapter/contact.dart';
import 'package:flutter_design_patterns/design_patterns/adapter/icontacts_adapter.dart';

class JsonContactsAdapter implements IContactsAdapter {
  final JsonContactsApi _api = JsonContactsApi();

  @override
  List<Contact> getContacts() {
    final contactsJson = _api.getContactsJson();
    final contactsList = _parseContactsJson(contactsJson);

    return contactsList;
  }

  List<Contact> _parseContactsJson(String contactsJson) {
    final contactsMap = json.decode(contactsJson) as Map<String, dynamic>;
    final contactsJsonList = contactsMap['contacts'] as List;
    final contactsList = contactsJsonList
        .map((json) => Contact(
              fullName: json['fullName'] as String,
              email: json['email'] as String,
              favourite: json['favourite'] as bool,
            ))
        .toList();

    return contactsList;
  }
}
