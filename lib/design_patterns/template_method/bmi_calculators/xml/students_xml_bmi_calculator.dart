import 'package:flutter_design_patterns/design_patterns/template_method/apis/xml_students_api.dart';
import 'package:xml/xml.dart' as xml;

import 'package:flutter_design_patterns/design_patterns/template_method/student.dart';
import 'package:flutter_design_patterns/design_patterns/template_method/students_bmi_calculation_template.dart';

class StudentsXmlBmiCalculator extends StudentsBmiCalculationTemplate {
  final XmlStudentsApi _api = XmlStudentsApi();

  @override
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
