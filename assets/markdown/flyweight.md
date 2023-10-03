## Class diagram

![Flyweight Class Diagram](resource:assets/images/flyweight/flyweight.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of the **Flyweight** design pattern:

![Flyweight Implementation Class Diagram](resource:assets/images/flyweight/flyweight_implementation.png)

The `ShapeType` is an enumerator class defining possible shape types - Circle and Square.

`IPositionedShape` defines a common interface for the specific shape classes:

- `render()` - renders the shape - returns the positioned shape widget. Also, the **extrinsic** state (x and y coordinates) are passed to this method to render the shape in the exact position.

`Circle` and `Square` are concrete positioned shape implementations of the `IPositionedShape` interface. Both of these shapes have their own **intrinsic** state: circle defines `color` and `diameter` properties while square contains `color`, `width` properties and a getter `height` which returns the same value as `width`.

The `ShapeFactory` is a simple factory class which creates and returns a specific shape object via the `createShape()` method by providing the `ShapeType`.

The `ShapeFlyweightFactory` is a flyweight factory which contains a map of flyweight objects - `shapesMap`. When the concrete flyweight is requested via the `getShape()` method, the flyweight factory checks whether it exists in the map and returns it from there. Otherwise, a new instance of the shape is created using the `ShapeFactory` and persisted in the map object for further usage.

The `FlyweightExample` initialises and contains the `ShapeFlyweightFactory` object. Also, it contains a list of positioned shape - `shapesList` - which is built using the `ShapeFlyweightFactory` and flyweight positioned shape objects.

### ShapeType

A special kind of class - `enumeration` - to define different shape types.

```dart
enum ShapeType {
  circle,
  square,
}
```

### IPositionedShape

An interface that defines the `render()` method to be implemented by concrete shape classes.

```dart
abstract interface class IPositionedShape {
  Widget render(double x, double y);
}
```

### Concrete shapes

- `Circle` - a specific implementation of the `IPositionedShape` interface representing the shape of a circle.

```dart
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

- `Square` - a specific implementation of the `IPositionedShape` interface representing the shape of a square.

```dart
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

A simple factory class that defines the `createShape()` method to create a concrete shape by providing its type.

```dart
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

```dart
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

`FlyweightExample` initialises and contains the `ShapeFlyweightFactory` class object. Also, for demonstration purposes, the `ShapeFactory` object is initialised here, too. Based on the selected option, either the `ShapeFactory` or `ShapeFlyweightFactory` is used to populate a list of `IPositionedShape` objects which are rendered in the background of the example screen.

With the `ShapeFlyweightFactory`, client - `FlyweightExample` widget - does not care about the flyweight objects' creation or management. `IPositionedShape` objects are requested from the factory by passing the `ShapeType`, flyweight factory keeps all the instances of the needed shapes itself, only returns references to them. Hence, only a single instance of a shape object per type could be created and reused when needed.

```dart
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
        for (final shape in _shapesList) PositionedShapeWrapper(shape: shape),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SwitchListTile.adaptive(
              title: const Text(
                'Use flyweight factory',
                style: TextStyle(fontWeight: FontWeight.bold),
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
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
```
