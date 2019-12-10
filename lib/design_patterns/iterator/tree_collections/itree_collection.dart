import 'package:flutter_design_patterns/design_patterns/iterator/tree_iterators/itree_iterator.dart';

abstract class ITreeCollection {
  ITreeIterator createIterator();
  String getTitle();
}
