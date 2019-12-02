import 'package:flutter_design_patterns/design_patterns/interpreter/iexpression.dart';

class Add implements IExpression {
  final IExpression leftExpression;
  final IExpression rightExpression;

  const Add(this.leftExpression, this.rightExpression);

  @override
  int interpret() {
    return leftExpression.interpret() + rightExpression.interpret();
  }
}
