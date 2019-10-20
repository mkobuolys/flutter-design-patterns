import 'package:flutter_design_patterns/design_patterns/adapter/contact.dart';

abstract class IContactsAdapter {
  List<Contact> getContacts();
}
