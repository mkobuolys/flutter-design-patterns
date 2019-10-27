import 'dart:math' as math;

import 'package:meta/meta.dart';

import 'package:flutter_design_patterns/design_patterns/template_method/student.dart';

abstract class StudentsBmiCalculationTemplate {
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
