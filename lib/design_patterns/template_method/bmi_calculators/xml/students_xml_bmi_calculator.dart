import 'package:flutter/foundation.dart';
import 'package:xml/xml.dart';

import '../../apis/xml_students_api.dart';
import '../../student.dart';
import '../../students_bmi_calculator.dart';

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
