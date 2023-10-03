## Class diagram

![Interpreter Class Diagram](resource:assets/images/interpreter/interpreter.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of the **Interpreter** design pattern.

![Interpreter Implementation Class Diagram](resource:assets/images/interpreter/interpreter_implementation.png)

`IExpression` defines a common interface for both terminal and nonterminal expressions which implement the `interpret()` method:

- `Number` - a terminal expression for numbers;
- `Multiply` - a nonterminal expression of the multiplication operation;
- `Subtract` - a nonterminal expression of the subtraction operation;
- `Add` - a nonterminal expression of the addition operation.

All of the nonterminal expressions contain left and right expressions of type `IExpression` which are used in the `interpret()` method to calculate the result of the operation.

`ExpressionContext` class contains the solution steps of the postfix expression and is used by the `ExpressionSection` widget to retrieve those steps and the `IExpression` interface implementing classes to add a specific solution step to the context.

`ExpressionSection` uses the `ExpressionHelpers` class to build the expression tree of the postfix expression and the `ExpressionContext` to retrieve the solution steps of the specific postfix expression.

### IExpression

An interface that defines the `interpret()` method to be implemented by the terminal and nonterminal expression classes.

```
abstract interface class IExpression {
  int interpret(ExpressionContext context);
}
```

### ExpressionContext

A class to define the context which stores the solution steps of the postfix expression and is used by the `Client` and classes implementing the `IExpression` interface.

```dart
class ExpressionContext {
  final List<String> _solutionSteps = [];

  List<String> getSolutionSteps() => _solutionSteps;

  void addSolutionStep(String operatorSymbol, int left, int right, int result) {
    final solutionStep =
        '${_solutionSteps.length + 1}) $left $operatorSymbol $right = $result';

    _solutionSteps.add(solutionStep);
  }
}
```

### ExpressionHelpers

A helper class which is used by the `Client` to build the expression tree from the provided postfix expression input.

```dart
class ExpressionHelpers {
  const ExpressionHelpers._();

  static final List<String> _operators = ['+', '-', '*'];

  static IExpression buildExpressionTree(String postfixExpression) {
    final expressionStack = ListQueue<IExpression>();

    for (final symbol in postfixExpression.split(' ')) {
      if (_isOperator(symbol)) {
        final rightExpression = expressionStack.removeLast();
        final leftExpression = expressionStack.removeLast();
        final nonterminalExpression =
            _getNonterminalExpression(symbol, leftExpression, rightExpression);

        expressionStack.addLast(nonterminalExpression);
      } else {
        final numberExpression = Number(int.parse(symbol));

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
  ) =>
      switch (symbol) {
        '+' => Add(leftExpression, rightExpression),
        '-' => Subtract(leftExpression, rightExpression),
        '*' => Multiply(leftExpression, rightExpression),
        _ => throw Exception('Expression is not defined.'),
      };
}
```

### Number

A terminal expression class to define the number in postfix expression.

```dart
class Number implements IExpression {
  const Number(this.number);

  final int number;

  @override
  int interpret(ExpressionContext context) => number;
}
```

### Nonterminal expressions

- `Add` - defines the addition operation and adds the addition solution step to the `ExpressionContext`. The result of this operation - left and right expressions' sum.

```dart
class Add implements IExpression {
  const Add(this.leftExpression, this.rightExpression);

  final IExpression leftExpression;
  final IExpression rightExpression;

  @override
  int interpret(ExpressionContext context) {
    final left = leftExpression.interpret(context);
    final right = rightExpression.interpret(context);
    final result = left + right;

    context.addSolutionStep('+', left, right, result);

    return result;
  }
}
```

- `Subtract` - defines the subtraction operation and adds the subtraction solution step to the `ExpressionContext`. The result of this operation - left and right expressions' difference.

```dart
class Subtract implements IExpression {
  const Subtract(this.leftExpression, this.rightExpression);

  final IExpression leftExpression;
  final IExpression rightExpression;

  @override
  int interpret(ExpressionContext context) {
    final left = leftExpression.interpret(context);
    final right = rightExpression.interpret(context);
    final result = left - right;

    context.addSolutionStep('-', left, right, result);

    return result;
  }
}
```

- `Multiply` - defines the multiplication operation and adds the multiplication solution step to the `ExpressionContext`. The result of this operation - left and right expressions' product.

```dart
class Multiply implements IExpression {
  const Multiply(this.leftExpression, this.rightExpression);

  final IExpression leftExpression;
  final IExpression rightExpression;

  @override
  int interpret(ExpressionContext context) {
    final left = leftExpression.interpret(context);
    final right = rightExpression.interpret(context);
    final result = left * right;

    context.addSolutionStep('*', left, right, result);

    return result;
  }
}
```

### Example

- `InterpreterExample` widget contains the list of postfix expressions. For each expression in the `_postfixExpressions` list, an `ExpressionSection` widget is created and a specific postfix expression is passed to it using the constructor.

```dart
class InterpreterExample extends StatefulWidget {
  const InterpreterExample();

  @override
  _InterpreterExampleState createState() => _InterpreterExampleState();
}

class _InterpreterExampleState extends State<InterpreterExample> {
  final List<String> _postfixExpressions = [
    '20 3 5 * - 2 3 * +',
    '1 1 1 1 1 + + + * 2 -',
    '123 12 1 - - 12 9 * -',
    '9 8 7 6 5 4 3 2 1 + - + - + - + -',
  ];

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: LayoutConstants.paddingL,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (final postfixExpression in _postfixExpressions)
              ExpressionSection(postfixExpression: postfixExpression),
          ],
        ),
      ),
    );
  }
}
```

- `ExpressionSection` uses the provided `postfixExpression` and builds its expression tree using the `ExpressionHelpers` class on the 'Solve' button click. The `buildExpressionTree()` method returns a single nonterminal expression of type `IExpression` which is used to calculate the final result of the provided postfix expression. The widget/method itself does not care about the specific implementation of the nonterminal expression, it only calls the `interpret()` method on the expression to get the final result. Also, a list of solution steps to get the final result are retrieved from the `ExpressionContext` using the `getSolutionSteps()` method and presented in the UI.

```dart
class ExpressionSection extends StatefulWidget {
  final String postfixExpression;

  const ExpressionSection({
    required this.postfixExpression,
  });

  @override
  _ExpressionSectionState createState() => _ExpressionSectionState();
}

class _ExpressionSectionState extends State<ExpressionSection> {
  final _expressionContext = ExpressionContext();
  final List<String> _solutionSteps = [];

  void _solvePrefixExpression() {
    final solutionSteps = <String>[];
    final expression =
        ExpressionHelpers.buildExpressionTree(widget.postfixExpression);
    final result = expression.interpret(_expressionContext);

    solutionSteps
      ..addAll(_expressionContext.getSolutionSteps())
      ..add('Result: $result');

    setState(() => _solutionSteps.addAll(solutionSteps));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.postfixExpression,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: LayoutConstants.spaceM),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 250),
          firstChild: PlatformButton(
            materialColor: Colors.black,
            materialTextColor: Colors.white,
            onPressed: _solvePrefixExpression,
            text: 'Solve',
          ),
          secondChild: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (final solutionStep in _solutionSteps)
                Text(
                  solutionStep,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
            ],
          ),
          crossFadeState: _solutionSteps.isEmpty
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
        ),
        const SizedBox(height: LayoutConstants.spaceXL),
      ],
    );
  }
}
```
