import 'expression_context.dart';

abstract interface class IExpression {
  int interpret(ExpressionContext context);
}
