import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/design_patterns/adapter/adapters/json_contacts_adapter.dart';
import 'package:flutter_design_patterns/design_patterns/adapter/adapters/xml_contacts_adapter.dart';

class AdapterExample extends StatelessWidget {
  final JsonContactsAdapter jsonContactsAdapter = JsonContactsAdapter();
  final XmlContactsAdapter xmlContactsAdapter = XmlContactsAdapter();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Adapter Example'),
    );
  }
}
