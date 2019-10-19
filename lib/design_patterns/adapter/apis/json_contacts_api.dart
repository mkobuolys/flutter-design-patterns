class JsonContactsApi {
  final String _contactsJson = '''
  {
    "contacts": [
      {
        "fullName": "John Doe",
        "email": "johndoe@email.com",
        "favourite": false
      },
      {
        "fullName": "Jane Doe",
        "email": "janedoe@email.com",
        "favourite": true
      },
      {
        "fullName": "John Roe",
        "email": "johnroe@email.com",
        "favourite": true
      }
    ]
  }
  ''';

  String getContactsJson() {
    return _contactsJson;
  }
}
