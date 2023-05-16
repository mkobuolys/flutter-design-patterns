import '../../expression_context.dart';
import '../../iexpression.dart';

class Number implements IExpression {
  const Number(this.number);

  final int number;

  @override
  int interpret(ExpressionContext context) => number;
}
