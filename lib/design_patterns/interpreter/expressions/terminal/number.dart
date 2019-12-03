import 'package:flutter_design_patterns/design_patterns/interpreter/expression_context.dart';
import 'package:flutter_design_patterns/design_patterns/interpreter/iexpression.dart';

class Number implements IExpression {
  final int number;

  const Number(this.number);

  @override
  int interpret(ExpressionContext context) {
    return number;
  }
}
