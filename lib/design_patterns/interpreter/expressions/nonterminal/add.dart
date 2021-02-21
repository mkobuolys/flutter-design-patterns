import '../../expression_context.dart';
import '../../iexpression.dart';

class Add implements IExpression {
  final IExpression leftExpression;
  final IExpression rightExpression;

  const Add(this.leftExpression, this.rightExpression);

  @override
  int interpret(ExpressionContext context) {
    final left = leftExpression.interpret(context);
    final right = rightExpression.interpret(context);
    final result = left + right;
    context.addSolutionStep('+', left, right, result);

    return result;
  }
}
