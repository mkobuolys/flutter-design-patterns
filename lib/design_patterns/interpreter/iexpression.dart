import 'package:flutter_design_patterns/design_patterns/interpreter/expression_context.dart';

abstract class IExpression {
  int interpret(ExpressionContext context);
}
