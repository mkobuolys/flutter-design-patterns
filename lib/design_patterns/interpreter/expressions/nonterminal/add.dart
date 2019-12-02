import 'package:flutter_design_patterns/design_patterns/interpreter/expression_context.dart';
import 'package:flutter_design_patterns/design_patterns/interpreter/iexpression.dart';

class Add implements IExpression {
  final IExpression leftExpression;
  final IExpression rightExpression;

  const Add(this.leftExpression, this.rightExpression);

  @override
  int interpret(ExpressionContext context) {
    var left = leftExpression.interpret(context);
    var right = rightExpression.interpret(context);
    var result = left + right;
    context.addSolutionStep('+', left, right, result);

    return result;
  }
}
