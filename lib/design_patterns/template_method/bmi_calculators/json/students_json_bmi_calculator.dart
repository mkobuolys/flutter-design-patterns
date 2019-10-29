import 'dart:convert';

import 'package:meta/meta.dart';

import 'package:flutter_design_patterns/design_patterns/template_method/apis/json_students_api.dart';
import 'package:flutter_design_patterns/design_patterns/template_method/student.dart';
import 'package:flutter_design_patterns/design_patterns/template_method/students_bmi_calculator.dart';

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
