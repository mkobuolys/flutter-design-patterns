## Class diagram

![Prototype Class Diagram](resource:assets/images/prototype/prototype.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of the **Prototype** design pattern.

![Prototype Implementation Class Diagram](resource:assets/images/prototype/prototype_implementation.png)

_Shape_ is an abstract class which is used as a base class for all the specific shapes. The class contains a _color_ property and defines several abstract methods:

- _clone()_ - an abstract method to clone (copy) the specific shape;
- _randomiseProperties()_ - an abstract method to randomise property values of the shape;
- _render()_ - an abstract method to render the shape. The method is used in UI.

_Circle_ and _Rectangle_ are concrete shape classes which extend the abstract class _Shape_ and implement its abstract methods.

_PrototypeExample_ initializes and contains several _Shape_ objects. These objects are rendered in the UI using the _render()_ method. Also, specific shape objects could be copied using _clone()_ and their properties could be randomised using _randomiseProperties()_ methods respectively.

### Shape

An abstract class which stores the shape's colour and defines several abstract methods. Also, this class contains several constructors:

- _Shape()_ - a basic constructor to create a shape object with the provided colour value;
- _Shape.clone()_ - a named constructor to create a shape object as a copy of the provided _Shape_ value.

```
abstract class Shape {
  Color color;

  Shape(this.color);

  Shape.clone(Shape source) {
    color = source.color;
  }

  Shape clone();
  void randomiseProperties();
  Widget render();
}
```

### Shapes

- _Circle_ - a specific class which defines a shape of a circle. The class defines a _radius_ property, extends the _Shape_ class and implements its abstract methods _clone()_, _randomiseProperties()_ and _render()_.

```
class Circle extends Shape {
  double radius;

  Circle(Color color, this.radius) : super(color);

  Circle.initial() : super(Colors.black) {
    radius = 50.0;
  }

  Circle.clone(Circle source) : super.clone(source) {
    radius = source.radius;
  }

  @override
  Shape clone() {
    return Circle.clone(this);
  }

  @override
  void randomiseProperties() {
    color = Color.fromRGBO(
        random.integer(255), random.integer(255), random.integer(255), 1.0);
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
          child: Icon(
            Icons.star,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
```

- _Rectangle_ - a specific class which defines a shape of a rectangle. The class defines _height_ and _width_ properties, extends the _Shape_ class and implements its abstract methods _clone()_, _randomiseProperties()_ and _render()_.

```
class Rectangle extends Shape {
  double height;
  double width;

  Rectangle(Color color, this.height, this.width) : super(color);

  Rectangle.initial() : super(Colors.black) {
    height = 100.0;
    width = 100.0;
  }

  Rectangle.clone(Rectangle source) : super.clone(source) {
    height = source.height;
    width = source.width;
  }

  @override
  Shape clone() {
    return Rectangle.clone(this);
  }

  @override
  void randomiseProperties() {
    color = Color.fromRGBO(
        random.integer(255), random.integer(255), random.integer(255), 1.0);
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
            shape: BoxShape.rectangle,
          ),
          child: Icon(
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

_PrototypeExample_ contains a couple of _Shape_ objects - _Circle_ and _Rectangle_. By pressing the _Randomise properties_ button, the values of shape's properties are randomised (the _randomiseProperties()_ method is called on the shape). Also, if the _Clone_ button is pressed, the _clone()_ method is called on the shape and a copy of that particular shape is crated with the exact same values of all the properties.

The _PrototypeExample_ does not care about the specific type of shape object as long as it extends the _Shape_ abstract class and implements all of its abstract methods. As a result, the _clone()_ method could be called on any shape, all of its properties are copied even though these are different on different shapes e.g. the circle has only the _radius_ property which is specific for that particular shape, while the rectangle has two different properties - _height_ and _width_.

```
class PrototypeExample extends StatefulWidget {
  @override
  _PrototypeExampleState createState() => _PrototypeExampleState();
}

class _PrototypeExampleState extends State<PrototypeExample> {
  final Shape _circle = Circle.initial();
  final Shape _rectangle = Rectangle.initial();

  Shape _circleClone;
  Shape _rectangleClone;

  void _randomiseCircleProperties() {
    setState(() {
      _circle.randomiseProperties();
    });
  }

  void _cloneCircle() {
    setState(() {
      _circleClone = _circle.clone();
    });
  }

  void _randomiseRectangleProperties() {
    setState(() {
      _rectangle.randomiseProperties();
    });
  }

  void _cloneRectangle() {
    setState(() {
      _rectangleClone = _rectangle.clone();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: paddingL),
        child: Column(
          children: <Widget>[
            ShapeColumn(
              shape: _circle,
              shapeClone: _circleClone,
              onClonePressed: _cloneCircle,
              onRandomisePropertiesPressed: _randomiseCircleProperties,
            ),
            Divider(),
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
