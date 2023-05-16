class JsonStudentsApi {
  static const _studentsJson = '''
  {
    "students": [
      {
        "fullName": "John Doe (JSON)",
        "age": 12,
        "height": 1.62,
        "weight": 53
      },
      {
        "fullName": "Emma Doe (JSON)",
        "age": 15,
        "height": 1.55,
        "weight": 50
      },
      {
        "fullName": "Michael Roe (JSON)",
        "age": 18,
        "height": 1.85,
        "weight": 89
      },
      {
        "fullName": "Emma Roe (JSON)",
        "age": 20,
        "height": 1.66,
        "weight": 79
      }
    ]
  }
  ''';

  const JsonStudentsApi();

  String getStudentsJson() => _studentsJson;
}
