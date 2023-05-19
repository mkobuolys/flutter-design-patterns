## Class diagram

![Prototype Class Diagram](resource:assets/images/prototype/prototype.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of the **Prototype** design pattern.

![Prototype Implementation Class Diagram](resource:assets/images/prototype/prototype_implementation.png)

`Shape` is an abstract class which is used as a base class for all the specific shapes. The class contains a `color` property and defines several abstract methods:

- `clone()` - clones (copies) the specific shape;
- `randomiseProperties()` - randomises property values of the shape;
- `render()` - renders the shape. The method is used in UI.

`Circle` and `Rectangle` are concrete shape classes which extend the abstract class `Shape` and implement its abstract methods.

`PrototypeExample` initializes and contains several `Shape` objects. These objects are rendered in the UI using the `render()` method. Also, specific shape objects could be copied using `clone()` and their properties could be randomised using `randomiseProperties()` methods respectively.

### Shape

An abstract class that stores the shape's colour and defines several abstract methods. Also, this class contains several constructors:

- `Shape()` - a basic constructor to create a shape object with the provided colour value;
- `Shape.clone()` - a named constructor to create a shape object as a copy of the provided `Shape` value.

```dart
abstract class Shape {
  Shape(this.color);

  Shape.clone(Shape source) : color = source.color;

  Color color;

  Shape clone();
  void randomiseProperties();
  Widget render();
}
```

### Shapes

- `Circle` - a specific class that defines a shape of a circle. The class defines a `radius` property, extends the `Shape` class and implements its abstract methods `clone()`, `randomiseProperties()` and `render()`.

```dart
class Circle extends Shape {
  Circle(super.color, this.radius);

  Circle.initial([super.color = Colors.black]) : radius = 50.0;

  Circle.clone(Circle super.source)
      : radius = source.radius,
        super.clone();

  double radius;

  @override
  Shape clone() => Circle.clone(this);

  @override
  void randomiseProperties() {
    color = Color.fromRGBO(
      random.integer(255),
      random.integer(255),
      random.integer(255),
      1.0,
    );
    radius = random.integer(50, min: 25).toDouble();
  }

  @override
  Widget render() {
    return SizedBox(
      height: 120.0,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          height: 2 * radius,
          width: 2 * radius,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.star,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
```

- `Rectangle` - a specific class that defines a shape of a rectangle. The class defines `height` and `width` properties, extends the `Shape` class and implements its abstract methods `clone()`, `randomiseProperties()` and `render()`.

```dart
class Rectangle extends Shape {
  Rectangle(super.color, this.height, this.width);

  Rectangle.initial([super.color = Colors.black])
      : height = 100.0,
        width = 100.0;

  Rectangle.clone(Rectangle super.source)
      : height = source.height,
        width = source.width,
        super.clone();

  double height;
  double width;

  @override
  Shape clone() => Rectangle.clone(this);

  @override
  void randomiseProperties() {
    color = Color.fromRGBO(
      random.integer(255),
      random.integer(255),
      random.integer(255),
      1.0,
    );
    height = random.integer(100, min: 50).toDouble();
    width = random.integer(100, min: 50).toDouble();
  }

  @override
  Widget render() {
    return SizedBox(
      height: 120.0,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: color,
          ),
          child: const Icon(
            Icons.star,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
```

### Example

`PrototypeExample` contains a couple of `Shape` objects - `Circle` and `Rectangle`. By pressing the `Randomise properties` button, the values of shape's properties are randomised (the `randomiseProperties()` method is called on the shape). Also, if the `Clone` button is pressed, the `clone()` method is called on the shape and a copy of that particular shape is crated with the exact same values of all the properties.

The `PrototypeExample` does not care about the specific type of shape object as long as it extends the `Shape` abstract class and implements all of its abstract methods. As a result, the `clone()` method could be called on any shape, all of its properties are copied even though these are different on different shapes e.g. the circle has only the `radius` property which is specific for that particular shape, while the rectangle has two different properties - `height` and `width`.

```dart
class PrototypeExample extends StatefulWidget {
  const PrototypeExample();

  @override
  _PrototypeExampleState createState() => _PrototypeExampleState();
}

class _PrototypeExampleState extends State<PrototypeExample> {
  final _circle = Circle.initial();
  final _rectangle = Rectangle.initial();

  Shape? _circleClone;
  Shape? _rectangleClone;

  void _randomiseCircleProperties() => setState(
        () => _circle.randomiseProperties(),
      );

  void _cloneCircle() => setState(() => _circleClone = _circle.clone());

  void _randomiseRectangleProperties() => setState(
        () => _rectangle.randomiseProperties(),
      );

  void _cloneRectangle() => setState(
        () => _rectangleClone = _rectangle.clone(),
      );

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: LayoutConstants.paddingL,
        ),
        child: Column(
          children: <Widget>[
            ShapeColumn(
              shape: _circle,
              shapeClone: _circleClone,
              onClonePressed: _cloneCircle,
              onRandomisePropertiesPressed: _randomiseCircleProperties,
            ),
            const Divider(),
            ShapeColumn(
              shape: _rectangle,
              shapeClone: _rectangleClone,
              onClonePressed: _cloneRectangle,
              onRandomisePropertiesPressed: _randomiseRectangleProperties,
            ),
          ],
        ),
      ),
    );
  }
}
```
