import 'package:meta/meta.dart';

import 'package:flutter_design_patterns/design_patterns/flyweight/ishape.dart';
import 'package:flutter_design_patterns/design_patterns/flyweight/shape_factory.dart';
import 'package:flutter_design_patterns/design_patterns/flyweight/shape_type.dart';

class ShapeFlyweightFactory {
  final ShapeFactory shapeFactory;
  final Map<ShapeType, IShape> shapesMap = Map<ShapeType, IShape>();

  ShapeFlyweightFactory({
    @required this.shapeFactory,
  }) : assert(shapeFactory != null);

  IShape getShape(ShapeType shapeType) {
    if (!shapesMap.containsKey(shapeType)) {
      shapesMap[shapeType] = shapeFactory.createShape(shapeType);
    }

    return shapesMap[shapeType];
  }

  int getShapeInstancesCount() {
    return shapesMap.length;
  }
}
