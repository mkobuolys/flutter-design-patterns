## Class diagram

![Interpreter Class Diagram](resource:assets/images/interpreter/interpreter.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of the **Interpreter** design pattern.

![Interpreter Implementation Class Diagram](resource:assets/images/interpreter/interpreter_implementation.png)

_IExpression_ defines a common interface for both terminal and nonterminal expressions which implement the _interpret()_ method:

- _Number_ - a terminal expression for numbers;
- _Multiply_ - a nonterminal expression of the multiplication operation;
- _Subtract_ - a nonterminal expression of the subtraction operation;
- _Add_ - a nonterminal expression of the addition operation.

All of the nonterminal expressions contain left and right expressions of type _IExpression_ which are used in the _interpret()_ method to calculate the result of the operation.

_ExpressionContext_ class contains the solution steps of the postfix expression and is used by the _ExpressionSection_ widget to retrieve those steps and the _IExpression_ interface implementing classes to add a specific solution step to the context.

_ExpressionSection_ uses the _ExpressionHelpers_ class to build the expression tree of the postfix expression and the _ExpressionContext_ to retrieve the solution steps of the specific postfix expression.

### IExpression

An interface which defines the _interpret()_ method to be implemented by the terminal and nonterminal expression classes. Dart language does not support the interface as a class type, so we define an interface by creating an abstract class and providing a method header (name, return type, parameters) without the default implementation.

```
abstract class IExpression {
  int interpret(ExpressionContext context);
}
```

### ExpressionContext

A class to define the context which stores the solution steps of the postfix expression and is used by the _Client_ and classes implementing the _IExpression_ interface.

```
class ExpressionContext {
  final List<String> _solutionSteps = List<String>();

  List<String> getSolutionSteps() {
    return _solutionSteps;
  }

  void addSolutionStep(String operatorSymbol, int left, int right, int result) {
    var solutionStep = '${_solutionSteps.length + 1}) $left $operatorSymbol $right = $result';

    _solutionSteps.add(solutionStep);
  }
}
```

### ExpressionHelpers

A helper class which is used by the _Client_ to build the expression tree from the provided postfix expression input.

```
class ExpressionHelpers {
  static final List<String> _operators = ['+', '-', '*'];

  static IExpression buildExpressionTree(String postfixExpression) {
    var expressionStack = ListQueue<IExpression>();

    for (var symbol in postfixExpression.split(' ')) {
      if (_isOperator(symbol)) {
        var rightExpression = expressionStack.removeLast();
        var leftExpression = expressionStack.removeLast();
        var nonterminalExpression = _getNonterminalExpression(symbol, leftExpression, rightExpression);

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
```

### Number

A terminal expression class to define the number in postfix expression.

```
class Number implements IExpression {
  final int number;

  const Number(this.number);

  @override
  int interpret(ExpressionContext context) {
    return number;
  }
}
```

### Nonterminal expressions

- _Add_ - defines the addition operation and adds the addition solution step to the _ExpressionContext_. The result of this operation - left and right expressions' sum.

```
class Add implements IExpression {
  final IExpression leftExpression;
  final IExpression rightExpression;

  const Add(this.leftExpression, this.rightExpression);

  @override
  int interpret(ExpressionContext context) {
    var left = leftExpression.interpret(context);
    var right = rightExpression.interpret(context);
    var result = left + right;
    context.addSolutionStep('+', left, right, result);

    return result;
  }
}
```

- _Subtract_ - defines the subtraction operation and adds the subtraction solution step to the _ExpressionContext_. The result of this operation - left and right expressions' difference.

```
class Subtract implements IExpression {
  final IExpression leftExpression;
  final IExpression rightExpression;

  const Subtract(this.leftExpression, this.rightExpression);

  @override
  int interpret(ExpressionContext context) {
    var left = leftExpression.interpret(context);
    var right = rightExpression.interpret(context);
    var result = left - right;
    context.addSolutionStep('-', left, right, result);

    return result;
  }
}
```

- _Multiply_ - defines the multiplication operation and adds the multiplication solution step to the _ExpressionContext_. The result of this operation - left and right expressions' product.

```
class Multiply implements IExpression {
  final IExpression leftExpression;
  final IExpression rightExpression;

  const Multiply(this.leftExpression, this.rightExpression);

  @override
  int interpret(ExpressionContext context) {
    var left = leftExpression.interpret(context);
    var right = rightExpression.interpret(context);
    var result = left * right;
    context.addSolutionStep('*', left, right, result);

    return result;
  }
}
```

### Example

- _InterpreterExample_ widget contains the list of postfix expressions. For each expression in the \__postfixExpressions_ list, an _ExpressionSection_ widget is created and a specific postfix expression is passed to it using the constructor.

```
class InterpreterExample extends StatefulWidget {
  @override
  _InterpreterExampleState createState() => _InterpreterExampleState();
}

class _InterpreterExampleState extends State<InterpreterExample> {
  final List<String> _postfixExpressions = [
    '20 3 5 * - 2 3 * +',
    '1 1 1 1 1 + + + * 2 -',
    '123 12 1 - - 12 9 * -',
    '9 8 7 6 5 4 3 2 1 + - + - + - + -'
  ];

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (var postfixExpression in _postfixExpressions)
              ExpressionSection(postfixExpression),
          ],
        ),
      ),
    );
  }
}
```

- _ExpressionSection_ uses the provided _postfixExpression_ and builds its expression tree using the _ExpressionHelpers_ class on the 'Solve' button click. The _buildExpressionTree()_ method returns a single nonterminal expression of type _IExpression_ which is used to calculate the final result of the provided postfix expression. The widget/method itself does not care about the specific implementation of the nonterminal expression, it only calls the _interpret()_ method on the expression to get the final result. Also, a list of solution steps to get the final result are retrieved from the _ExpressionContext_ using the _getSolutionSteps()_ method and presented in the UI.

```
class ExpressionSection extends StatefulWidget {
  final String postfixExpression;

  const ExpressionSection(
    this.postfixExpression,
  ) : assert(postfixExpression != null);

  @override
  _ExpressionSectionState createState() => _ExpressionSectionState();
}

class _ExpressionSectionState extends State<ExpressionSection> {
  final ExpressionContext _expressionContext = ExpressionContext();
  final List<String> _solutionSteps = List<String>();

  void _solvePrefixExpression() {
    var solutionSteps = List<String>();
    var expression = ExpressionHelpers.buildExpressionTree(widget.postfixExpression);
    var result = expression.interpret(_expressionContext);

    solutionSteps
      ..addAll(_expressionContext.getSolutionSteps())
      ..add('Result: $result');

    setState(() {
      _solutionSteps.addAll(solutionSteps);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.postfixExpression,
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: spaceM),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 250),
          firstChild: PlatformButton(
            child: Text('Solve'),
            materialColor: Colors.black,
            materialTextColor: Colors.white,
            onPressed: _solvePrefixExpression,
          ),
          secondChild: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (var solutionStep in _solutionSteps)
                Text(
                  solutionStep,
                  style: Theme.of(context).textTheme.subtitle2,
                )
            ],
          ),
          crossFadeState: _solutionSteps.isEmpty
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
        ),
        const SizedBox(height: spaceXL),
      ],
    );
  }
}
```
