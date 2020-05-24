## Class diagram

![Flyweight Class Diagram](resource:assets/images/flyweight/flyweight.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of **Flyweight** design pattern.

![Flyweight Implementation Class Diagram](resource:assets/images/flyweight/flyweight_implementation.png)

Text

### ShapeType

Text

```
enum ShapeType {
  Circle,
  Square,
}
```

### IPositionedShape

Text

```
abstract class IPositionedShape {
  Widget render(double x, double y);
}
```

### Concrete shapes

- _Circle_ -

```
class Circle implements IPositionedShape {
  final Color color;
  final double diameter;

  Circle({
    @required this.color,
    @required this.diameter,
  })  : assert(color != null),
        assert(diameter != null);

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

- _Square_ -

```
class Square implements IPositionedShape {
  final Color color;
  final double width;

  Square({
    @required this.color,
    @required this.width,
  })  : assert(color != null),
        assert(width != null);

  double get height => width;

  @override
  Widget render(double x, double y) {
    return Positioned(
      left: x,
      bottom: y,
      child: Container(
        height: height,
        width: width,
        color: color,
      ),
    );
  }
}
```

### ShapeFactory

Text

```
class ShapeFactory {
  IPositionedShape createShape(ShapeType shapeType) {
    switch (shapeType) {
      case ShapeType.Circle:
        return Circle(
          color: Colors.red.withOpacity(0.2),
          diameter: 10.0,
        );
      case ShapeType.Square:
        return Square(
          color: Colors.blue.withOpacity(0.2),
          width: 10.0,
        );
      default:
        throw new Exception("Shape type '$shapeType' is not supported.");
    }
  }
}
```

### ShapeFlyweightFactory

Text

```
class ShapeFlyweightFactory {
  final ShapeFactory shapeFactory;
  final Map<ShapeType, IPositionedShape> shapesMap = Map<ShapeType, IPositionedShape>();

  ShapeFlyweightFactory({
    @required this.shapeFactory,
  }) : assert(shapeFactory != null);

  IPositionedShape getShape(ShapeType shapeType) {
    if (!shapesMap.containsKey(shapeType)) {
      shapesMap[shapeType] = shapeFactory.createShape(shapeType);
    }

    return shapesMap[shapeType];
  }

  int getShapeInstancesCount() {
    return shapesMap.length;
  }
}
```

### Example

Text

```
class FlyweightExample extends StatefulWidget {
  @override
  _FlyweightExampleState createState() => _FlyweightExampleState();
}

class _FlyweightExampleState extends State<FlyweightExample> {
  static const int SHAPES_COUNT = 1000;

  final ShapeFactory shapeFactory = ShapeFactory();

  ShapeFlyweightFactory _shapeFlyweightFactory;
  List<IPositionedShape> _shapesList;

  int _shapeInstancesCount = 0;
  bool _useFlyweightFactory = false;

  @override
  void initState() {
    super.initState();

    _shapeFlyweightFactory = ShapeFlyweightFactory(
      shapeFactory: shapeFactory,
    );

    _buildShapesList();
  }

  void _buildShapesList() {
    var shapeInstancesCount = 0;
    _shapesList = List<IPositionedShape>();

    for (var i = 0; i < SHAPES_COUNT; i++) {
      var shapeType = _getRandomShapeType();
      var shape = _useFlyweightFactory
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
    var values = ShapeType.values;

    return values[Random().nextInt(values.length)];
  }

  void _toggleUseFlyweightFactory(bool value) {
    setState(() {
      _useFlyweightFactory = value;
    });

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
              title: Text(
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
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
```
