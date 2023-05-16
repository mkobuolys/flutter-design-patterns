import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../design_patterns/template_method/template_method.dart';
import 'students_section.dart';

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
