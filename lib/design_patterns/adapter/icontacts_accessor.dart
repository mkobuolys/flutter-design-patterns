import 'package:flutter_design_patterns/design_patterns/adapter/contact.dart';

abstract class IContactsAccessor {
  List<Contact> getContacts();
}
