import 'dart:collection';

import 'package:flutter_design_patterns/design_patterns/interpreter/expressions/nonterminal/add.dart';
import 'package:flutter_design_patterns/design_patterns/interpreter/expressions/nonterminal/multiply.dart';
import 'package:flutter_design_patterns/design_patterns/interpreter/expressions/nonterminal/subtract.dart';
import 'package:flutter_design_patterns/design_patterns/interpreter/expressions/terminal/number.dart';
import 'package:flutter_design_patterns/design_patterns/interpreter/iexpression.dart';

class ExpressionHelpers {
  static final List<String> _operators = ['+', '-', '*'];

  static IExpression buildExpressionTree(String postfixExpression) {
    var expressionStack = ListQueue<IExpression>();

    for (var symbol in postfixExpression.split(' ')) {
      if (_isOperator(symbol)) {
        var rightExpression = expressionStack.removeLast();
        var leftExpression = expressionStack.removeLast();
        var nonterminalExpression =
            _getNonterminalExpression(symbol, leftExpression, rightExpression);

        expressionStack.addLast(nonterminalExpression);
      } else {
        var numberExpression = Number(int.parse(symbol));

        expressionStack.addLast(numberExpression);
      }
    }

    return expressionStack.single;
  }

  static bool _isOperator(String symbol) {
    return _operators.contains(symbol);
  }

  static IExpression _getNonterminalExpression(
    String symbol,
    IExpression leftExpression,
    IExpression rightExpression,
  ) {
    IExpression expression;

    switch (symbol) {
      case '+':
        expression = Add(leftExpression, rightExpression);
        break;
      case '-':
        expression = Subtract(leftExpression, rightExpression);
        break;
      case '*':
        expression = Multiply(leftExpression, rightExpression);
        break;
      default:
        throw Exception('Expression is not defined.');
    }

    return expression;
  }
}
