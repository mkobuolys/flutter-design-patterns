## Class diagram

![Iterator Class Diagram](resource:assets/images/iterator/iterator.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of the **Iterator** design pattern.

![Iterator Implementation Class Diagram](resource:assets/images/iterator/iterator_implementation.png)

`ITreeCollection` defines a common interface for all the specific tree collections:

- `createIterator()` - creates an iterator for the specific tree collection;
- `getTitle()` - returns the title of the tree collection which is used in the UI.

`DepthFirstTreeCollection` and `BreadthFirstTreeCollection` are concrete implementations of the `ITreeCollection` interface. `DepthFirstTreeCollection` creates the `DepthFirstIterator` while `BreadthFirstTreeCollection` creates the `BreadthFirstIterator`. Also, both of these collections stores the `Graph` object to save the tree data structure itself.

`ITreeIterator` defines a common interface for all specific iterators of the tree collection:

- `hasNext()` - returns true if the iterator did not reach the end of the collection yet, otherwise false;
- `getNext()` - returns the next value of the collection;
- `reset()` - resets the iterator and sets the current position of it to the beginning.

`DepthFirstIterator` and `BreadthFirstIterator` are concrete implementations of the `ITreeIterator` interface. `DepthFirstIterator` implements the **depth-first** algorithm to traverse the tree collection. Correspondingly, `BreadthFirstIterator` implements the **breadth-first** algorithm. The main difference between these two algorithms is the order in which all of the nodes are visited. Hence, the depth-first algorithm is implemented using the **stack** data structure while the breadth-first algorithm uses the **queue** data structure to store nodes (vertices) which should be visited next.

`IteratorExample` references both interfaces - `ITreeCollection` and `ITreeIterator` - to specify the required tree collection and create an appropriate iterator for it.

### Graph

A class which stores the adjacency list of the graph. It is stored as a map data structure where the key represents the node's (vertix) id and the value is a list of vertices (ids of other nodes) adjacent to the vertex of that id (key). Also, this class defines the `addEdge()` method to add an edge to the adjacency list.

```dart
class Graph {
  final Map<int, Set<int>> adjacencyList = {};

  void addEdge(int source, int target) => adjacencyList.containsKey(source)
      ? adjacencyList[source]!.add(target)
      : adjacencyList[source] = {target};
}
```

### ITreeCollection

An interface that defines methods to be implemented by all specific tree collection classes.

```dart
abstract interface class ITreeCollection {
  ITreeIterator createIterator();
  String getTitle();
}
```

### Tree collections

- `DepthFirstTreeCollection` - a tree collection class that stores the graph object and implements the `createIterator()` method to create an iterator which uses the depth-first algorithm to traverse the graph.

```dart
class DepthFirstTreeCollection implements ITreeCollection {
  const DepthFirstTreeCollection(this.graph);

  final Graph graph;

  @override
  ITreeIterator createIterator() => DepthFirstIterator(this);

  @override
  String getTitle() => 'Depth-first';
}
```

- `BreadthFirstTreeCollection` - a tree collection class that stores the graph object and implements the `createIterator()` method to create an iterator which uses the breadth-first algorithm to traverse the graph.

```dart
class BreadthFirstTreeCollection implements ITreeCollection {
  const BreadthFirstTreeCollection(this.graph);

  final Graph graph;

  @override
  ITreeIterator createIterator() => BreadthFirstIterator(this);

  @override
  String getTitle() => 'Breadth-first';
}
```

### ITreeIterator

An interface that defines methods to be implemented by all specific iterators of the tree collection.

```dart
abstract interface class ITreeIterator {
  bool hasNext();
  int? getNext();
  void reset();
}
```

### Tree iterators

- `DepthFirstIterator` - a specific implementation of the tree iterator which traverses the tree collection by using the depth-first algorithm. This algorithm uses the **stack** data structure to store vertices (nodes) which should be visited next using the `getNext()` method.

```dart
class DepthFirstIterator implements ITreeIterator {
  final DepthFirstTreeCollection treeCollection;
  final Set<int> visitedNodes = <int>{};
  final ListQueue<int> nodeStack = ListQueue<int>();

  final _initialNode = 1;
  late int _currentNode;

  DepthFirstIterator(this.treeCollection) {
    _currentNode = _initialNode;
    nodeStack.add(_initialNode);
  }

  Map<int, Set<int>> get adjacencyList => treeCollection.graph.adjacencyList;

  @override
  bool hasNext() => nodeStack.isNotEmpty;

  @override
  int? getNext() {
    if (!hasNext()) return null;

    _currentNode = nodeStack.removeLast();
    visitedNodes.add(_currentNode);

    if (adjacencyList.containsKey(_currentNode)) {
      for (final node in adjacencyList[_currentNode]!
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

- `BreadthFirstIterator` - a specific implementation of the tree iterator which traverses the tree collection by using the breadth-first algorithm. This algorithm uses the **queue** data structure to store vertices (nodes) which should be visited next using the `getNext()` method.

```dart
class BreadthFirstIterator implements ITreeIterator {
  final BreadthFirstTreeCollection treeCollection;
  final Set<int> visitedNodes = <int>{};
  final ListQueue<int> nodeQueue = ListQueue<int>();

  final _initialNode = 1;
  late int _currentNode;

  BreadthFirstIterator(this.treeCollection) {
    _currentNode = _initialNode;
    nodeQueue.add(_initialNode);
  }

  Map<int, Set<int>> get adjacencyList => treeCollection.graph.adjacencyList;

  @override
  bool hasNext() => nodeQueue.isNotEmpty;

  @override
  int? getNext() {
    if (!hasNext()) return null;

    _currentNode = nodeQueue.removeFirst();
    visitedNodes.add(_currentNode);

    if (adjacencyList.containsKey(_currentNode)) {
      for (final node in adjacencyList[_currentNode]!
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

`IteratorExample` widget is responsible for building the tree (graph) using the `Graph` class and contains a list of tree collection objects. After selecting the specific tree collection from the list and triggering the `traverseTree()` method, an appropriate iterator of that particular tree collection is created and used to traverse the tree data structure.
As you can see in the `traverseTree()` method, all the implementation details of the tree collection's traversal are hidden from the client, it only uses the `hasNext()` and `getNext()` methods defined by the `ITreeIterator` interface to iterate through all of the vertices (nodes) of the built `Graph` object (tree).

```dart
class IteratorExample extends StatefulWidget {
  const IteratorExample();

  @override
  _IteratorExampleState createState() => _IteratorExampleState();
}

class _IteratorExampleState extends State<IteratorExample> {
  final List<ITreeCollection> treeCollections = [];

  var _selectedTreeCollectionIndex = 0;
  int? _currentNodeIndex = 0;
  var _isTraversing = false;

  @override
  void initState() {
    super.initState();

    final graph = _buildGraph();

    treeCollections
      ..add(BreadthFirstTreeCollection(graph))
      ..add(DepthFirstTreeCollection(graph));
  }

  Graph _buildGraph() => Graph()
    ..addEdge(1, 2)
    ..addEdge(1, 3)
    ..addEdge(1, 4)
    ..addEdge(2, 5)
    ..addEdge(3, 6)
    ..addEdge(3, 7)
    ..addEdge(4, 8);

  void _setSelectedTreeCollectionIndex(int? index) {
    if (index == null) return;

    setState(() => _selectedTreeCollectionIndex = index);
  }

  Future<void> _traverseTree() async {
    _toggleIsTraversing();

    final iterator =
        treeCollections[_selectedTreeCollectionIndex].createIterator();

    while (iterator.hasNext()) {
      if (!mounted) return;

      setState(() => _currentNodeIndex = iterator.getNext());

      await Future.delayed(const Duration(seconds: 1));
    }

    _toggleIsTraversing();
  }

  void _toggleIsTraversing() => setState(() => _isTraversing = !_isTraversing);

  void _reset() => setState(() => _currentNodeIndex = 0);

  Color _getBackgroundColor(int index) =>
      _currentNodeIndex == index ? Colors.red[200]! : Colors.white;

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
            TreeCollectionSelection(
              treeCollections: treeCollections,
              selectedIndex: _selectedTreeCollectionIndex,
              onChanged:
                  !_isTraversing ? _setSelectedTreeCollectionIndex : null,
            ),
            const SizedBox(height: LayoutConstants.spaceL),
            Wrap(
              alignment: WrapAlignment.center,
              children: <Widget>[
                PlatformButton(
                  materialColor: Colors.black,
                  materialTextColor: Colors.white,
                  onPressed: _currentNodeIndex == 0 ? _traverseTree : null,
                  text: 'Traverse',
                ),
                PlatformButton(
                  materialColor: Colors.black,
                  materialTextColor: Colors.white,
                  onPressed:
                      _isTraversing || _currentNodeIndex == 0 ? null : _reset,
                  text: 'Reset',
                ),
              ],
            ),
            const SizedBox(height: LayoutConstants.spaceL),
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
