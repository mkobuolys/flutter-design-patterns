import 'dart:convert';

import 'package:meta/meta.dart';

import '../../apis/json_students_api.dart';
import '../../student.dart';
import '../../students_bmi_calculator.dart';

class TeenageStudentsJsonBmiCalculator extends StudentsBmiCalculator {
  final JsonStudentsApi _api = JsonStudentsApi();

  @override
  @protected
  List<Student> getStudentsData() {
    final studentsJson = _api.getStudentsJson();
    final studentsMap = json.decode(studentsJson) as Map<String, dynamic>;
    final studentsJsonList = studentsMap['students'] as List;
    final studentsList = studentsJsonList
        .map((json) => Student(
              fullName: json['fullName'] as String,
              age: json['age'] as int,
              height: json['height'] as double,
              weight: json['weight'] as int,
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
