import 'package:flutter_design_patterns/design_patterns/iterator/graph.dart';
import 'package:flutter_design_patterns/design_patterns/iterator/tree_collections/itree_collection.dart';
import 'package:flutter_design_patterns/design_patterns/iterator/tree_iterators/depth_first_iterator.dart';
import 'package:flutter_design_patterns/design_patterns/iterator/tree_iterators/itree_iterator.dart';

class DepthFirstTreeCollection implements ITreeCollection {
  final Graph graph;

  const DepthFirstTreeCollection(this.graph);

  ITreeIterator getIterator() {
    return DepthFirstIterator(this);
  }
}
