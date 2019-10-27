import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/constants.dart';
import 'package:flutter_design_patterns/design_patterns/template_method/bmi_calculators/json/students_json_bmi_calculator.dart';
import 'package:flutter_design_patterns/design_patterns/template_method/bmi_calculators/json/teenage_students_json_bmi_calculator.dart';
import 'package:flutter_design_patterns/design_patterns/template_method/bmi_calculators/xml/students_xml_bmi_calculator.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/template_method/students_section.dart';

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
