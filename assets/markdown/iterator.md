## Class diagram

![Iterator Class Diagram](resource:assets/images/iterator/iterator.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of the **Iterator** design pattern.

![Iterator Implementation Class Diagram](resource:assets/images/iterator/iterator_implementation.png)

_ITreeCollection_ defines a common interface for all the specific tree collections:

- _createIterator()_ - creates an iterator for the specific tree collection;
- _getTitle()_ - returns the title of the tree collection which is used in the UI.

_DepthFirstTreeCollection_ and _BreadthFirstTreeCollection_ are concrete implementations of the _ITreeCollection_ interface. _DepthFirstTreeCollection_ creates the _DepthFirstIterator_ while _BreadthFirstTreeCollection_ creates the _BreadthFirstIterator_. Also, both of these collections stores the _Graph_ object to save the tree data structure itself.

_ITreeIterator_ defines a common interface for all specific iterators of the tree collection:

- _hasNext()_ - returns true if the iterator did not reach the end of the collection yet, otherwise false;
- _getNext()_ - returns the next value of the collection;
- _reset()_ - resets the iterator and sets the current position of it to the beginning.

_DepthFirstIterator_ and _BreadthFirstIterator_ are concrete implementations of the _ITreeIterator_ interface. _DepthFirstIterator_ implements the **depth-first** algorithm to traverse the tree collection. Correspondingly, _BreadthFirstIterator_ implements the **breadth-first** algorithm. The main difference between these two algorithms is the order in which all of the nodes are visited. Hence, the depth-first algorithm is implemented using the **stack** data structure while the breadth-first algorithm uses the **queue** data structure to store nodes (vertices) which should be visited next.

_IteratorExample_ references both interfaces - _ITreeCollection_ and _ITreeIterator_ - to specify the required tree collection and create an appropriate iterator for it.

### Graph

A class which stores the adjacency list of the graph. It is stored as a map data structure where the key represents the node's (vertix) id and the value is a list of vertices (ids of other nodes) adjacent to the vertex of that id (key). Also, this class defines the _addEdge()_ method to add an edge to the adjacency list.

```
class Graph {
  final Map<int, Set<int>> adjacencyList = Map<int, Set<int>>();

  void addEdge(int source, int target) {
    if (adjacencyList.containsKey(source)) {
      adjacencyList[source].add(target);
    } else {
      adjacencyList[source] = {target};
    }
  }
}
```

### ITreeCollection

An interface which defines methods to be implemented by all specific tree collection classes. Dart language does not support the interface as a class type, so we define an interface by creating an abstract class and providing a method header (name, return type, parameters) without the default implementation.

```
abstract class ITreeCollection {
  ITreeIterator createIterator();
  String getTitle();
}
```

### Tree collections

- _DepthFirstTreeCollection_ - a tree collection class which stores the graph object and implements the _createIterator()_ method to create an iterator which uses the depth-first algorithm to traverse the graph.

```
class DepthFirstTreeCollection implements ITreeCollection {
  final Graph graph;

  const DepthFirstTreeCollection(this.graph);

  @override
  ITreeIterator createIterator() {
    return DepthFirstIterator(this);
  }

  @override
  String getTitle() {
    return 'Depth-first';
  }
}
```

- _BreadthFirstTreeCollection_ - a tree collection class which stores the graph object and implements the _createIterator()_ method to create an iterator which uses the breadth-first algorithm to traverse the graph.

```
class BreadthFirstTreeCollection implements ITreeCollection {
  final Graph graph;

  const BreadthFirstTreeCollection(this.graph);

  @override
  ITreeIterator createIterator() {
    return BreadthFirstIterator(this);
  }

  @override
  String getTitle() {
    return 'Breadth-first';
  }
}
```

### ITreeIterator

An interface which defines methods to be implemented by all specific iterators of the tree collection.

```
abstract class ITreeIterator {
  bool hasNext();
  int getNext();
  void reset();
}
```

### Tree iterators

- _DepthFirstIterator_ - a specific implementation of the tree iterator which traverses the tree collection by using the depth-first algorithm. This algorithm uses the **stack** data structure to store vertices (nodes) which should be visited next using the _getNext()_ method.

```
class DepthFirstIterator implements ITreeIterator {
  final DepthFirstTreeCollection treeCollection;
  final Set<int> visitedNodes = <int>{};
  final ListQueue<int> nodeStack = ListQueue<int>();

  final int _initialNode = 1;
  int _currentNode;

  DepthFirstIterator(this.treeCollection) {
    _currentNode = _initialNode;
    nodeStack.add(_initialNode);
  }

  Map<int, Set<int>> get adjacencyList => treeCollection.graph.adjacencyList;

  @override
  bool hasNext() {
    return nodeStack.isNotEmpty;
  }

  @override
  int getNext() {
    if (!hasNext()) {
      return null;
    }

    _currentNode = nodeStack.removeLast();
    visitedNodes.add(_currentNode);

    if (adjacencyList.containsKey(_currentNode)) {
      for (var node in adjacencyList[_currentNode]
          .where((n) => !visitedNodes.contains(n))) {
        nodeStack.addLast(node);
      }
    }

    return _currentNode;
  }

  @override
  void reset() {
    _currentNode = _initialNode;
    visitedNodes.clear();
    nodeStack.clear();
    nodeStack.add(_initialNode);
  }
}
```

- _BreadthFirstIterator_ - a specific implementation of the tree iterator which traverses the tree collection by using the breadth-first algorithm. This algorithm uses the **queue** data structure to store vertices (nodes) which should be visited next using the _getNext()_ method.

```
class BreadthFirstIterator implements ITreeIterator {
  final BreadthFirstTreeCollection treeCollection;
  final Set<int> visitedNodes = <int>{};
  final ListQueue<int> nodeQueue = ListQueue<int>();

  final int _initialNode = 1;
  int _currentNode;

  BreadthFirstIterator(this.treeCollection) {
    _currentNode = _initialNode;
    nodeQueue.add(_initialNode);
  }

  Map<int, Set<int>> get adjacencyList => treeCollection.graph.adjacencyList;

  @override
  bool hasNext() {
    return nodeQueue.isNotEmpty;
  }

  @override
  int getNext() {
    if (!hasNext()) {
      return null;
    }

    _currentNode = nodeQueue.removeFirst();
    visitedNodes.add(_currentNode);

    if (adjacencyList.containsKey(_currentNode)) {
      for (var node in adjacencyList[_currentNode]
          .where((n) => !visitedNodes.contains(n))) {
        nodeQueue.addLast(node);
      }
    }

    return _currentNode;
  }

  @override
  void reset() {
    _currentNode = _initialNode;
    visitedNodes.clear();
    nodeQueue.clear();
    nodeQueue.add(_initialNode);
  }
}
```

### Example

_IteratorExample_ widget is responsible for building the tree (graph) using the _Graph_ class and contains a list of tree collection objects. After selecting the specific tree collection from the list and triggering the _traverseTree()_ method, an appropriate iterator of that particular tree collection is created and used to traverse the tree data structure.
As you can see in the _traverseTree()_ method, all the implementation details of the tree collection's traversal are hidden from the client, it only uses the _hasNext()_ and _getNext()_ methods defined by the _ITreeIterator_ interface to iterate through all of the vertices (nodes) of the built _Graph_ object (tree).

```
class IteratorExample extends StatefulWidget {
  @override
  _IteratorExampleState createState() => _IteratorExampleState();
}

class _IteratorExampleState extends State<IteratorExample> {
  final List<ITreeCollection> treeCollections = List<ITreeCollection>();

  int _selectedTreeCollectionIndex = 0;
  int _currentNodeIndex = 0;
  bool _isTraversing = false;

  @override
  void initState() {
    super.initState();

    var graph = _buildGraph();
    treeCollections.add(BreadthFirstTreeCollection(graph));
    treeCollections.add(DepthFirstTreeCollection(graph));
  }

  Graph _buildGraph() {
    var graph = Graph();

    graph.addEdge(1, 2);
    graph.addEdge(1, 3);
    graph.addEdge(1, 4);
    graph.addEdge(2, 5);
    graph.addEdge(3, 6);
    graph.addEdge(3, 7);
    graph.addEdge(4, 8);

    return graph;
  }

  void _setSelectedTreeCollectionIndex(int index) {
    setState(() {
      _selectedTreeCollectionIndex = index;
    });
  }

  Future _traverseTree() async {
    _toggleIsTraversing();

    var iterator =
        treeCollections[_selectedTreeCollectionIndex].createIterator();

    while (iterator.hasNext()) {
      setState(() {
        _currentNodeIndex = iterator.getNext();
      });
      await Future.delayed(const Duration(seconds: 1));
    }

    _toggleIsTraversing();
  }

  void _toggleIsTraversing() {
    setState(() {
      _isTraversing = !_isTraversing;
    });
  }

  void _reset() {
    setState(() {
      _currentNodeIndex = 0;
    });
  }

  Color _getBackgroundColor(int index) {
    return _currentNodeIndex == index ? Colors.red[200] : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: paddingL),
        child: Column(
          children: <Widget>[
            TreeCollectionSelection(
              treeCollections: treeCollections,
              selectedIndex: _selectedTreeCollectionIndex,
              onChanged:
                  !_isTraversing ? _setSelectedTreeCollectionIndex : null,
            ),
            const SizedBox(height: spaceL),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                PlatformButton(
                  child: Text('Traverse'),
                  materialColor: Colors.black,
                  materialTextColor: Colors.white,
                  onPressed: _currentNodeIndex == 0 ? _traverseTree : null,
                ),
                PlatformButton(
                  child: Text('Reset'),
                  materialColor: Colors.black,
                  materialTextColor: Colors.white,
                  onPressed:
                      _isTraversing || _currentNodeIndex == 0 ? null : _reset,
                ),
              ],
            ),
            const SizedBox(height: spaceL),
            Box(
              nodeId: 1,
              color: _getBackgroundColor(1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Box(
                    nodeId: 2,
                    color: _getBackgroundColor(2),
                    child: Box(
                      nodeId: 5,
                      color: _getBackgroundColor(5),
                    ),
                  ),
                  Box(
                    nodeId: 3,
                    color: _getBackgroundColor(3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Box(
                          nodeId: 6,
                          color: _getBackgroundColor(6),
                        ),
                        Box(
                          nodeId: 7,
                          color: _getBackgroundColor(7),
                        ),
                      ],
                    ),
                  ),
                  Box(
                    nodeId: 4,
                    color: _getBackgroundColor(4),
                    child: Box(
                      nodeId: 8,
                      color: _getBackgroundColor(8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```
