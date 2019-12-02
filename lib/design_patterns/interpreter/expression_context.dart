import 'dart:collection';

import 'package:flutter_design_patterns/design_patterns/interpreter/expressions/non_terminal/add.dart';
import 'package:flutter_design_patterns/design_patterns/interpreter/expressions/non_terminal/product.dart';
import 'package:flutter_design_patterns/design_patterns/interpreter/expressions/non_terminal/substract.dart';
import 'package:flutter_design_patterns/design_patterns/interpreter/expressions/terminal/number.dart';
import 'package:flutter_design_patterns/design_patterns/interpreter/iexpression.dart';

class ExpressionContext {
  final List<String> _operators = ['+', '-', '*'];

  List<String> solvePostfixExpression(String postfixExpression) {
    var expressionStack = ListQueue<IExpression>();
    var solutionSteps = List<String>();
    var postfixExpressionList = postfixExpression.split(' ');

    for (var postfixExpression in postfixExpressionList) {
      if (_isOperator(postfixExpression)) {
        var rightExpression = expressionStack.removeLast();
        var leftExpression = expressionStack.removeLast();
        var expression =
            _getExpression(postfixExpression, leftExpression, rightExpression);
        var operationResult = expression.interpret();

        expressionStack.addLast(Number(operationResult));
        solutionSteps.add(
          _getSolutionStep(
            solutionSteps.length + 1,
            postfixExpression,
            leftExpression.interpret(),
            rightExpression.interpret(),
            operationResult,
          ),
        );
      } else {
        var numberExpression = Number(int.parse(postfixExpression));

        expressionStack.addLast(numberExpression);
      }
    }

    var finalResult = expressionStack.removeLast().interpret().toString();
    solutionSteps.add('Result: $finalResult');

    return solutionSteps;
  }

  bool _isOperator(String symbol) {
    return _operators.contains(symbol);
  }

  IExpression _getExpression(
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
        expression = Substract(leftExpression, rightExpression);
        break;
      case '*':
        expression = Product(leftExpression, rightExpression);
        break;
      default:
        throw Exception('Expression is not defined.');
    }

    return expression;
  }

  String _getSolutionStep(
    int step,
    String operatorSymbol,
    int left,
    int right,
    int result,
  ) {
    return '$step) $left $operatorSymbol $right = $result';
  }
}
