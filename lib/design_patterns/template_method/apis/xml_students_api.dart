class XmlStudentsApi {
  static const _studentsXml = '''
  <?xml version="1.0"?>
  <students>
    <student>
      <fullname>John Doe (XML)</fullname>
      <age>12</age>
      <height>1.62</height>
      <weight>53</weight>
    </student>
    <student>
      <fullname>Emma Doe (XML)</fullname>
      <age>15</age>
      <height>1.55</height>
      <weight>50</weight>
    </student>
    <student>
      <fullname>Michael Roe (XML)</fullname>
      <age>18</age>
      <height>1.85</height>
      <weight>89</weight>
    </student>
    <student>
      <fullname>Emma Roe (XML)</fullname>
      <age>20</age>
      <height>1.66</height>
      <weight>79</weight>
    </student>
  </students>
  ''';

  const XmlStudentsApi();

  String getStudentsXml() => _studentsXml;
}
