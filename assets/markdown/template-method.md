## Class diagram

![Template Method Class Diagram](resource:assets/images/template_method/template_method.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of **Template Method** design pattern.

![Template Method Implementation Class Diagram](resource:assets/images/template_method/template_method_implementation.png)

The main class in the diagram is _StudentsBmiCalculator_. Its primary purpose is to define a template of the BMI calculation algorithm which returns a list of _Student_ objects (with the calculated BMI for each student) as a result via _calculateBmiAndReturnStudentList()_ method. This abstract class is used as a template (base class) for the concrete implementations of the students' BMI calculation algorithm - _StudentsXmlBmiCalculator_, _StudentsJsonBmiCalculator_ and _TeenageStudentsJsonBmiCalculator_. _StudentsXmlBmiCalculator_ uses the _XmlStudentsApi_ to retrieve students information as an XML string and returns it as a list of _Student_ objects via the overridden _getStudentsData()_ method. Both of the other two implementations (_StudentsJsonBmiCalculator_ and _TeenageStudentsJsonBmiCalculator_) uses the _JsonStudentsApi_ to retrieve students information in JSON format and returns the parsed data via the overridden _getStudentsData()_ method. However, _TeenageStudentsJsonBmiCalculator_ additionally reimplements (overrides) the _doStudentsFiltering()_ hook method to filter out not teenage students before calculating the BMI values. _StudentsSection_ UI widget uses the _StudentsBmiCalculator_ abstraction to retrieve and represent the calculated results in _TemplateMethodExample_ widget.

### StudentsBmiCalculator

An abstract (template) class for the BMI calculation algorithm. The algorithm consists of several steps:

1.  Retrieve students data - _getStudentsData()_;
2.  Do students filtering (if needed) - _doStudentsFiltering()_;
3.  Calculate the BMI for each student - _\_calculateStudentsBmi()_;
4.  Return students data - _return studentList_.

The first step is mandatory and should be implemented in each concrete implementation of the students BMI calculator - that is, the method _getStudentsData()_ is abstract and must be overridden in the derived class. Students filtering step is optional, yet it could be overridden in the derived class. For this reason, _doStudentsFiltering()_ method has a default implementation which does not change the workflow of the algorithm by default - this kind of method is called a **hook** method. Other steps are defined in the algorithm's template itself, are common for all implementations and could not be changed.

```
abstract class StudentsBmiCalculator {
  List<Student> calculateBmiAndReturnStudentList() {
    var studentList = getStudentsData();
    studentList = doStudentsFiltering(studentList);
    _calculateStudentsBmi(studentList);
    return studentList;
  }

  void _calculateStudentsBmi(List<Student> studentList) {
    for (var student in studentList) {
      student.bmi = _calculateBmi(student.height, student.weight);
    }
  }

  double _calculateBmi(double height, int weight) {
    return weight / math.pow(height, 2);
  }

  // Hook methods
  @protected
  List<Student> doStudentsFiltering(List<Student> studentList) {
    return studentList;
  }

  // Abstract methods
  @protected
  List<Student> getStudentsData();
}
```

### StudentsXmlBmiCalculator

A concrete implementation of the BMI calculation algorithm which uses _XmlStudentsApi_ to retrieve data and implements the _getStudentsData()_ method.

```
class StudentsXmlBmiCalculator extends StudentsBmiCalculator {
  final XmlStudentsApi _api = XmlStudentsApi();

  @override
  @protected
  List<Student> getStudentsData() {
    var studentsXml = _api.getStudentsXml();
    var xmlDocument = xml.parse(studentsXml);
    var studentsList = List<Student>();

    for (var xmlElement in xmlDocument.findAllElements('student')) {
      var fullName = xmlElement.findElements('fullname').single.text;
      var age = int.parse(xmlElement.findElements('age').single.text);
      var height = double.parse(xmlElement.findElements('height').single.text);
      var weight = int.parse(xmlElement.findElements('weight').single.text);

      studentsList.add(Student(
        fullName: fullName,
        age: age,
        height: height,
        weight: weight,
      ));
    }

    return studentsList;
  }
}
```

### StudentsJsonBmiCalculator

A concrete implementation of the BMI calculation algorithm which uses _JsonStudentsApi_ to retrieve data and implements the _getStudentsData()_ method.

```
class StudentsJsonBmiCalculator extends StudentsBmiCalculator {
  final JsonStudentsApi _api = JsonStudentsApi();

  @override
  @protected
  List<Student> getStudentsData() {
    var studentsJson = _api.getStudentsJson();
    var studentsMap = json.decode(studentsJson) as Map<String, dynamic>;
    var studentsJsonList = studentsMap['students'] as List;
    var studentsList = studentsJsonList
        .map((json) => Student(
              fullName: json['fullName'],
              age: json['age'],
              height: json['height'],
              weight: json['weight'],
            ))
        .toList();

    return studentsList;
  }
}
```

### TeenageStudentsJsonBmiCalculator

A concrete implementation of the BMI calculation algorithm which uses _JsonStudentsApi_ to retrieve data and implements the _getStudentsData()_ method. Additionally, the _doStudentsFiltering()_ hook method is overridden to filter out not teenage students.

```
class TeenageStudentsJsonBmiCalculator extends StudentsBmiCalculator {
  final JsonStudentsApi _api = JsonStudentsApi();

  @override
  @protected
  List<Student> getStudentsData() {
    var studentsJson = _api.getStudentsJson();
    var studentsMap = json.decode(studentsJson) as Map<String, dynamic>;
    var studentsJsonList = studentsMap['students'] as List;
    var studentsList = studentsJsonList
        .map((json) => Student(
              fullName: json['fullName'],
              age: json['age'],
              height: json['height'],
              weight: json['weight'],
            ))
        .toList();

    return studentsList;
  }

  @override
  @protected
  List<Student> doStudentsFiltering(List<Student> studentList) {
    return studentList
        .where((student) => student.age > 12 && student.age < 20)
        .toList();
  }
}
```

### Student

A simple class to store the student's information.

```
class Student {
  final String fullName;
  final int age;
  final double height;
  final int weight;
  double bmi;

  Student({
    this.fullName,
    this.age,
    this.height,
    this.weight,
  });
}
```

### JsonStudentsApi

A fake API which returns students' information as JSON string.

```
class JsonStudentsApi {
  final String _studentsJson = '''
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

  String getStudentsJson() {
    return _studentsJson;
  }
}
```

### XmlStudentsApi

A fake API which returns students' information as an XML string.

```
class XmlStudentsApi {
  final String _studentsXml = '''
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

  String getStudentsXml() {
    return _studentsXml;
  }
}
```

### Example

- TemplateMethodExample - implements the example widget. This widget uses _StudentsSection_ component which requires a specific BMI calculator of type _StudentsBmiCalculator_ to be provided via a constructor. For this example, we inject three different implementations of BMI calculator (_StudentsXmlBmiCalculator_, _StudentsJsonBmiCalculator_ and _TeenageStudentsJsonBmiCalculator_) which extend the same template (base class) - _StudentsBmiCalculator_ - to three different _StudentsSection_ widgets.

```
class TemplateMethodExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StudentsSection(
              bmiCalculator: StudentsXmlBmiCalculator(),
              headerText: 'Students from XML data source:',
            ),
            const SizedBox(height: spaceL),
            StudentsSection(
              bmiCalculator: StudentsJsonBmiCalculator(),
              headerText: 'Students from JSON data source:',
            ),
            const SizedBox(height: spaceL),
            StudentsSection(
              bmiCalculator: TeenageStudentsJsonBmiCalculator(),
              headerText: 'Students from JSON data source (teenagers only):',
            ),
          ],
        ),
      ),
    );
  }
}
```

- StudentsSection - uses the injected BMI calculator of type _StudentsBmiCalculator_. The widget does not care about the specific implementation of the BMI calculator as long as it uses (extends) the same template (base class). This lets us provide different students' BMI calculation algorithms/implementations without making any changes to the UI code.

```
class StudentsSection extends StatefulWidget {
  final StudentsBmiCalculator bmiCalculator;
  final String headerText;

  const StudentsSection({
    @required this.bmiCalculator,
    @required this.headerText,
  })  : assert(bmiCalculator != null),
        assert(headerText != null);

  @override
  _StudentsSectionState createState() => _StudentsSectionState();
}

class _StudentsSectionState extends State<StudentsSection> {
  final List<Student> students = List<Student>();

  void _calculateBmiAndGetStudentsData() {
    setState(() {
      students.addAll(widget.bmiCalculator.calculateBmiAndReturnStudentList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
	    ...
    );
  }
}
```
