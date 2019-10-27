import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/constants.dart';
import 'package:flutter_design_patterns/design_patterns/template_method/student.dart';
import 'package:flutter_design_patterns/design_patterns/template_method/students_bmi_calculation_template.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/template_method/students_data_table.dart';
import 'package:flutter_design_patterns/widgets/platform_specific/platform_button.dart';

class StudentsSection extends StatefulWidget {
  final StudentsBmiCalculationTemplate bmiCalculator;
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(widget.headerText),
        const SizedBox(height: spaceM),
        Stack(
          children: <Widget>[
            AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: students.length > 0 ? 1.0 : 0.0,
              child: StudentsDataTable(
                students: students,
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: students.length == 0 ? 1.0 : 0.0,
              child: PlatformButton(
                child: Text('Calculate BMI and get students\' data'),
                materialColor: Colors.black,
                materialTextColor: Colors.white,
                onPressed: _calculateBmiAndGetStudentsData,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
