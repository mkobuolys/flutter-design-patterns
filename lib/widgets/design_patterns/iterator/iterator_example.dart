import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/design_patterns/iterator/graph.dart';
import 'package:flutter_design_patterns/design_patterns/iterator/tree_collections/breadth_first_tree_collection.dart';
import 'package:flutter_design_patterns/design_patterns/iterator/tree_collections/depth_first_tree_collection.dart';

class IteratorExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var graph = Graph();
    graph.addEdge(1, 2);
    graph.addEdge(1, 3);
    graph.addEdge(1, 4);
    graph.addEdge(2, 5);
    graph.addEdge(3, 6);
    graph.addEdge(3, 7);
    graph.addEdge(4, 8);

    var dfsColl = DepthFirstTreeCollection(graph);
    var bfsColl = BreadthFirstTreeCollection(graph);
    var dfsIterator = dfsColl.getIterator();
    var bfsIterator = bfsColl.getIterator();
    while (dfsIterator.hasNext()) {
      print(dfsIterator.getNext());
    }
    print('---');
    while (bfsIterator.hasNext()) {
      print(bfsIterator.getNext());
    }
    dfsIterator.reset();
    bfsIterator.reset();
    print('---');
    print('---');
    while (dfsIterator.hasNext()) {
      print(dfsIterator.getNext());
    }
    print('---');
    while (bfsIterator.hasNext()) {
      print(bfsIterator.getNext());
    }
    return Center(
      child: Text('Iterator Example'),
    );
  }
}
