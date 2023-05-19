## Class diagram

![Template Method Class Diagram](resource:assets/images/template_method/template_method.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of **Template Method** design pattern.

![Template Method Implementation Class Diagram](resource:assets/images/template_method/template_method_implementation.png)

The main class in the diagram is `StudentsBmiCalculator`. Its primary purpose is to define a template of the BMI calculation algorithm which returns a list of `Student` objects (with the calculated BMI for each student) as a result via `calculateBmiAndReturnStudentList()` method. This abstract class is used as a template for the concrete implementations of the students' BMI calculation algorithm - `StudentsXmlBmiCalculator`, `StudentsJsonBmiCalculator` and `TeenageStudentsJsonBmiCalculator`. `StudentsXmlBmiCalculator` uses the `XmlStudentsApi` to retrieve students information as an XML string and returns it as a list of `Student` objects via the overridden `getStudentsData()` method. Both of the other two implementations (`StudentsJsonBmiCalculator` and `TeenageStudentsJsonBmiCalculator`) uses the `JsonStudentsApi` to retrieve students information in JSON format and returns the parsed data via the overridden `getStudentsData()` method. However, `TeenageStudentsJsonBmiCalculator` additionally reimplements (overrides) the `doStudentsFiltering()` hook method to filter out non-teenage students before calculating the BMI values. `StudentsSection` UI widget uses the `StudentsBmiCalculator` abstraction to retrieve and represent the calculated results in `TemplateMethodExample` widget.

### StudentsBmiCalculator

An abstract (template) class for the BMI calculation algorithm. The algorithm consists of several steps:

1.  Retrieve students data - `getStudentsData()`;
2.  Do students filtering (if needed) - `doStudentsFiltering()`;
3.  Calculate the BMI for each student - ``calculateStudentsBmi()`;
4.  Return students data - `return studentList`.

The first step is mandatory and should be implemented in each concrete implementation of the students BMI calculator - that is, the method `getStudentsData()` is abstract and must be overridden in the derived class. Students filtering step is optional, yet it could be overridden in the derived class. For this reason, `doStudentsFiltering()` method has a default implementation which does not change the workflow of the algorithm by default - this kind of method is called a **hook** method. Other steps are defined in the algorithm's template itself, are common for all implementations and could not be changed.

```dart
abstract class StudentsBmiCalculator {
  const StudentsBmiCalculator();

  List<Student> calculateBmiAndReturnStudentList() {
    var studentList = getStudentsData();
    studentList = doStudentsFiltering(studentList);
    _calculateStudentsBmi(studentList);
    return studentList;
  }

  void _calculateStudentsBmi(List<Student> studentList) {
    for (final student in studentList) {
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

A concrete implementation of the BMI calculation algorithm which uses `XmlStudentsApi` to retrieve data and implements the `getStudentsData()` method.

```dart
class StudentsXmlBmiCalculator extends StudentsBmiCalculator {
  const StudentsXmlBmiCalculator({
    this.api = const XmlStudentsApi(),
  });

  final XmlStudentsApi api;

  @override
  @protected
  List<Student> getStudentsData() {
    final studentsXml = api.getStudentsXml();
    final xmlDocument = XmlDocument.parse(studentsXml);
    final studentsList = <Student>[];

    for (final xmlElement in xmlDocument.findAllElements('student')) {
      final fullName = xmlElement.findElements('fullname').single.innerText;
      final age = int.parse(xmlElement.findElements('age').single.innerText);
      final height =
          double.parse(xmlElement.findElements('height').single.innerText);
      final weight =
          int.parse(xmlElement.findElements('weight').single.innerText);

      studentsList.add(
        Student(
          fullName: fullName,
          age: age,
          height: height,
          weight: weight,
        ),
      );
    }

    return studentsList;
  }
}
```

### StudentsJsonBmiCalculator

A concrete implementation of the BMI calculation algorithm which uses `JsonStudentsApi` to retrieve data and implements the `getStudentsData()` method.

```dart
class StudentsJsonBmiCalculator extends StudentsBmiCalculator {
  const StudentsJsonBmiCalculator({
    this.api = const JsonStudentsApi(),
  });

  final JsonStudentsApi api;

  @override
  @protected
  List<Student> getStudentsData() {
    final studentsJson = api.getStudentsJson();
    final studentsMap = json.decode(studentsJson) as Map<String, dynamic>;
    final studentsJsonList = studentsMap['students'] as List;
    final studentsList = studentsJsonList.map((json) {
      final studentJson = json as Map<String, dynamic>;

      return Student(
        fullName: studentJson['fullName'] as String,
        age: studentJson['age'] as int,
        height: studentJson['height'] as double,
        weight: studentJson['weight'] as int,
      );
    }).toList();

    return studentsList;
  }
}
```

### TeenageStudentsJsonBmiCalculator

A concrete implementation of the BMI calculation algorithm which uses `JsonStudentsApi` to retrieve data and implements the `getStudentsData()` method. Additionally, the `doStudentsFiltering()` hook method is overridden to filter out non-teenage students.

```dart
class TeenageStudentsJsonBmiCalculator extends StudentsBmiCalculator {
  const TeenageStudentsJsonBmiCalculator({
    this.api = const JsonStudentsApi(),
  });

  final JsonStudentsApi api;

  @override
  @protected
  List<Student> getStudentsData() {
    final studentsJson = api.getStudentsJson();
    final studentsMap = json.decode(studentsJson) as Map<String, dynamic>;
    final studentsJsonList = studentsMap['students'] as List;
    final studentsList = studentsJsonList.map((json) {
      final studentJson = json as Map<String, dynamic>;

      return Student(
        fullName: studentJson['fullName'] as String,
        age: studentJson['age'] as int,
        height: studentJson['height'] as double,
        weight: studentJson['weight'] as int,
      );
    }).toList();

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

```dart
class Student {
  final String fullName;
  final int age;
  final double height;
  final int weight;
  late final double bmi;

  Student({
    required this.fullName,
    required this.age,
    required this.height,
    required this.weight,
  });
}
```

### JsonStudentsApi

A fake API which returns students' information as JSON string.

```dart
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
```

### XmlStudentsApi

A fake API which returns students' information as an XML string.

```dart
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
```

### Example

- TemplateMethodExample - implements the example widget. This widget uses `StudentsSection` component which requires a specific BMI calculator of type `StudentsBmiCalculator` to be provided via a constructor. For this example, we inject three different implementations of BMI calculator (`StudentsXmlBmiCalculator`, `StudentsJsonBmiCalculator` and `TeenageStudentsJsonBmiCalculator`) which extend the same template (base class) - `StudentsBmiCalculator` - to three different `StudentsSection` widgets.

```dart
class TemplateMethodExample extends StatelessWidget {
  const TemplateMethodExample();

  @override
  Widget build(BuildContext context) {
    return const ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: LayoutConstants.paddingL,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StudentsSection(
              bmiCalculator: StudentsXmlBmiCalculator(),
              headerText: 'Students from XML data source:',
            ),
            SizedBox(height: LayoutConstants.spaceL),
            StudentsSection(
              bmiCalculator: StudentsJsonBmiCalculator(),
              headerText: 'Students from JSON data source:',
            ),
            SizedBox(height: LayoutConstants.spaceL),
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

- StudentsSection - uses the injected BMI calculator of type `StudentsBmiCalculator`. The widget does not care about the specific implementation of the BMI calculator as long as it uses (extends) the same template (base class). This lets us provide different students' BMI calculation algorithms/implementations without making any changes to the UI code.

```dart
class StudentsSection extends StatefulWidget {
  final StudentsBmiCalculator bmiCalculator;
  final String headerText;

  const StudentsSection({
    required this.bmiCalculator,
    required this.headerText,
  });

  @override
  _StudentsSectionState createState() => _StudentsSectionState();
}

class _StudentsSectionState extends State<StudentsSection> {
  final List<Student> students = [];

  void _calculateBmiAndGetStudentsData() {
    setState(() {
      students.addAll(widget.bmiCalculator.calculateBmiAndReturnStudentList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
	   // ...
    );
  }
}
```
