import '../graph.dart';
import '../tree_iterators/depth_first_iterator.dart';
import '../tree_iterators/itree_iterator.dart';
import 'itree_collection.dart';

class DepthFirstTreeCollection implements ITreeCollection {
  const DepthFirstTreeCollection(this.graph);

  final Graph graph;

  @override
  ITreeIterator createIterator() => DepthFirstIterator(this);

  @override
  String getTitle() => 'Depth-first';
}
