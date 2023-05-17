## Class diagram

![Flyweight Class Diagram](resource:assets/images/flyweight/flyweight.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of the **Flyweight** design pattern:

![Flyweight Implementation Class Diagram](resource:assets/images/flyweight/flyweight_implementation.png)

The _ShapeType_ is an enumerator class defining possible shape types - Circle and Square.

_IPositionedShape_ defines a common interface for the specific shape classes:

- _render()_ - renders the shape - returns the positioned shape widget. Also, the **extrinsic** state (x and y coordinates) are passed to this method to render the shape in the exact position.

_Circle_ and _Square_ are concrete positioned shape implementations of the _IPositionedShape_ interface. Both of these shapes have their own **intrinsic** state: circle defines _color_ and _diameter_ properties while square contains _color_, _width_ properties and a getter _height_ which returns the same value as _width_.

The _ShapeFactory_ is a simple factory class which creates and returns a specific shape object via the _createShape()_ method by providing the _ShapeType_.

The _ShapeFlyweightFactory_ is a flyweight factory which contains a map of flyweight objects - _shapesMap_. When the concrete flyweight is requested via the _getShape()_ method, the flyweight factory checks whether it exists in the map and returns it from there. Otherwise, a new instance of the shape is created using the _ShapeFactory_ and persisted in the map object for further usage.

The _FlyweightExample_ initialises and contains the _ShapeFlyweightFactory_ object. Also, it contains a list of positioned shape - _shapesList_ - which is built using the _ShapeFlyweightFactory_ and flyweight positioned shape objects.

### ShapeType

A special kind of class - _enumeration_ - to define different shape types.

```
enum ShapeType {
  circle,
  square,
}
```

### IPositionedShape

An interface that defines the _render()_ method to be implemented by concrete shape classes.

```
abstract interface class IPositionedShape {
  Widget render(double x, double y);
}
```

### Concrete shapes

- _Circle_ - a specific implementation of the _IPositionedShape_ interface representing the shape of a circle.

```
class Circle implements IPositionedShape {
  const Circle({
    required this.color,
    required this.diameter,
  });

  final Color color;
  final double diameter;

  @override
  Widget render(double x, double y) {
    return Positioned(
      left: x,
      bottom: y,
      child: Container(
        height: diameter,
        width: diameter,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
```

- _Square_ - a specific implementation of the _IPositionedShape_ interface representing the shape of a square.

```
class Square implements IPositionedShape {
  const Square({
    required this.color,
    required this.width,
  });

  final Color color;
  final double width;

  double get _height => width;

  @override
  Widget render(double x, double y) {
    return Positioned(
      left: x,
      bottom: y,
      child: Container(
        height: _height,
        width: width,
        color: color,
      ),
    );
  }
}
```

### ShapeFactory

A simple factory class that defines the _createShape()_ method to create a concrete shape by providing its type.

```
class ShapeFactory {
  const ShapeFactory();

  IPositionedShape createShape(ShapeType shapeType) => switch (shapeType) {
        ShapeType.circle => Circle(
            color: Colors.red.withOpacity(0.2),
            diameter: 10.0,
          ),
        ShapeType.square => Square(
            color: Colors.blue.withOpacity(0.2),
            width: 10.0,
          ),
      };
}
```

### ShapeFlyweightFactory

A flyweight factory class that keeps track of all the flyweight objects and creates them if needed.

```
class ShapeFlyweightFactory {
  ShapeFlyweightFactory({
    required this.shapeFactory,
  });

  final ShapeFactory shapeFactory;
  final Map<ShapeType, IPositionedShape> shapesMap = {};

  IPositionedShape getShape(ShapeType shapeType) {
    if (!shapesMap.containsKey(shapeType)) {
      shapesMap[shapeType] = shapeFactory.createShape(shapeType);
    }

    return shapesMap[shapeType]!;
  }

  int getShapeInstancesCount() => shapesMap.length;
}
```

### Example

_FlyweightExample_ initialises and contains the _ShapeFlyweightFactory_ class object. Also, for demonstration purposes, the _ShapeFactory_ object is initialised here, too. Based on the selected option, either the _ShapeFactory_ or _ShapeFlyweightFactory_ is used to populate a list of _IPositionedShape_ objects which are rendered in the background of the example screen.

With the _ShapeFlyweightFactory_, client - _FlyweightExample_ widget - does not care about the flyweight objects' creation or management. _IPositionedShape_ objects are requested from the factory by passing the _ShapeType_, flyweight factory keeps all the instances of the needed shapes itself, only returns references to them. Hence, only a single instance of a shape object per type could be created and reused when needed.

```
class FlyweightExample extends StatefulWidget {
  const FlyweightExample();

  @override
  _FlyweightExampleState createState() => _FlyweightExampleState();
}

class _FlyweightExampleState extends State<FlyweightExample> {
  static const shapesCount = 1000;

  final shapeFactory = const ShapeFactory();

  late final ShapeFlyweightFactory _shapeFlyweightFactory;
  late List<IPositionedShape> _shapesList;

  var _shapeInstancesCount = 0;
  var _useFlyweightFactory = false;

  @override
  void initState() {
    super.initState();

    _shapeFlyweightFactory = ShapeFlyweightFactory(shapeFactory: shapeFactory);

    _buildShapesList();
  }

  void _buildShapesList() {
    var shapeInstancesCount = 0;
    _shapesList = <IPositionedShape>[];

    for (var i = 0; i < shapesCount; i++) {
      final shapeType = _getRandomShapeType();
      final shape = _useFlyweightFactory
          ? _shapeFlyweightFactory.getShape(shapeType)
          : shapeFactory.createShape(shapeType);

      shapeInstancesCount++;
      _shapesList.add(shape);
    }

    setState(() {
      _shapeInstancesCount = _useFlyweightFactory
          ? _shapeFlyweightFactory.getShapeInstancesCount()
          : shapeInstancesCount;
    });
  }

  ShapeType _getRandomShapeType() {
    const values = ShapeType.values;

    return values[Random().nextInt(values.length)];
  }

  void _toggleUseFlyweightFactory(bool value) {
    setState(() => _useFlyweightFactory = value);

    _buildShapesList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        for (var shape in _shapesList)
          PositionedShapeWrapper(
            shape: shape,
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SwitchListTile.adaptive(
              title: const Text(
                'Use flyweight factory',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              activeColor: Colors.black,
              value: _useFlyweightFactory,
              onChanged: _toggleUseFlyweightFactory,
            ),
          ],
        ),
        Center(
          child: Text(
            'Shape instances count: $_shapeInstancesCount',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
```
