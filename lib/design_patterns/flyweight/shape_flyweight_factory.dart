import 'package:meta/meta.dart';

import 'ipositioned_shape.dart';
import 'shape_factory.dart';
import 'shape_type.dart';

class ShapeFlyweightFactory {
  final ShapeFactory shapeFactory;
  final Map<ShapeType, IPositionedShape> shapesMap = {};

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
