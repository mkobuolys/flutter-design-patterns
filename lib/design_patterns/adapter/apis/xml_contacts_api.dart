class XmlContactsApi {
  final String _contactsXml = '''
  <?xml version="1.0"?>
  <contacts>
    <contact>
      <fullname>John Doe</fullname>
      <email>johndoe@email.com</email>
      <favourite>false</favourite>
    </contact>
    <contact>
      <fullname>Jane Doe</fullname>
      <email>janedoe@email.com</email>
      <favourite>true</favourite>
    </contact>
    <contact>
      <fullname>John Roe</fullname>
      <email>johnroe@email.com</email>
      <favourite>true</favourite>
    </contact>
  </contacts>
  ''';

  String getContactsXml() {
    return _contactsXml;
  }
}
