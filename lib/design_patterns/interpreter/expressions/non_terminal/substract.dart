import 'package:flutter_design_patterns/design_patterns/interpreter/iexpression.dart';

class Substract implements IExpression {
  final IExpression leftExpression;
  final IExpression rightExpression;

  const Substract(this.leftExpression, this.rightExpression);

  @override
  int interpret() {
    return leftExpression.interpret() - rightExpression.interpret();
  }
}
