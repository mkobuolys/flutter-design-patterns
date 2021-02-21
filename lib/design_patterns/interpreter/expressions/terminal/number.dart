import '../../expression_context.dart';
import '../../iexpression.dart';

class Number implements IExpression {
  final int number;

  const Number(this.number);

  @override
  int interpret(ExpressionContext context) {
    return number;
  }
}
