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
