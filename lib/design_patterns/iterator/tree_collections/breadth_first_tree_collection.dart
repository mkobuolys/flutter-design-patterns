import 'package:flutter_design_patterns/design_patterns/iterator/graph.dart';
import 'package:flutter_design_patterns/design_patterns/iterator/tree_collections/itree_collection.dart';
import 'package:flutter_design_patterns/design_patterns/iterator/tree_iterators/breadth_first_iterator.dart';
import 'package:flutter_design_patterns/design_patterns/iterator/tree_iterators/itree_iterator.dart';

class BreadthFirstTreeCollection implements ITreeCollection {
  final Graph graph;

  const BreadthFirstTreeCollection(this.graph);

  ITreeIterator getIterator() {
    return BreadthFirstIterator(this);
  }
}
