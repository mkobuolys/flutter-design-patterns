import 'package:flutter_design_patterns/design_patterns/interpreter/iexpression.dart';

class Product implements IExpression {
  final IExpression leftExpression;
  final IExpression rightExpression;

  const Product(this.leftExpression, this.rightExpression);

  @override
  int interpret() {
    return leftExpression.interpret() * rightExpression.interpret();
  }
}
