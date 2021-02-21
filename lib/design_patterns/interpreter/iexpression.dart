import 'expression_context.dart';

abstract class IExpression {
  int interpret(ExpressionContext context);
}
