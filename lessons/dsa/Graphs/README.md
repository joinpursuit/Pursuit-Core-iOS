# Graphs

## Objectives

1. Explain the different types of graphs
2. Build a graph in Swift
3. Iterate through a graph in swift
4. Solve problems with graphs


## 0. Trees Review

- Building a binary tree
- DFS traversal with a Queue
- BFS traversals (pre-order, in-order, and post-order)

## 1. Graph Vocabulary

- A `Graph` is a data structure used to show the relationship of `verticies` and `edges`
- A `vertex` is a node that has a value and a list of edges
- An `edge` is a line connecting two verticies.  It can either be `weighted` or `unweighted`
- An `unweighted` graph is a graph where every edge has the same value (like a social network)
- A `weighted` graph is a graph where each edge can have different values (like traffic on roads connecting cities)
- A `undirected` graph is a graph where every edge connects verticies in both directions
- A `directed` graph is a graph where edges represent one-way paths

## 2. Graph Types

| |Weighted | Unweighted |
|---|---|---|
| **Directed** | ![graph](https://www.informatik.fb2.frankfurt-university.de/~doeben/I-ALGO/I-ALGO-TH/VL7/i-algo-th7-bild-graph1.gif) |  ![graph](http://cs.umw.edu/~finlayson/class/fall12/cpsc230/notes/images/directed.png) |
| **Undirected** | ![graph](https://i.stack.imgur.com/ea2UI.png) |![graph](https://i.stack.imgur.com/mPzx7.gif)


## 3. Building a Graph in Swift

```swift
class Vertex<T: Equatable> {
    var key: T
    var neighbors = [Edge<T>]()
    var visited: Bool = false
    init(key: T) {
        self.key = key
    }
}

class Edge<T: Equatable> {
    var neighbor: Vertex<T>
    var weight: Double
    init(neighbor: Vertex<T>, weight: Double) {
        self.neighbor = neighbor
        self.weight = weight
    }
}
```

## 4. Traverse through a graph

<details>
<summary>Sample Graph in Swift</summary>

```swift
let rootVertex = Vertex(key: 1)
let vertexTwo = Vertex(key: 2)
let vertexThree = Vertex(key: 3)
let vertexFour = Vertex(key: 4)
let vertexFive = Vertex(key: 5)


rootVertex.neighbors = [Edge(neighbor: vertexTwo, weight: 52.4),
                        Edge(neighbor: vertexFour, weight: 23.9),
                        Edge(neighbor: vertexFive, weight: 10.3)]

vertexTwo.neighbors = [Edge(neighbor: vertexThree, weight: 93.4)]

vertexThree.neighbors = []

vertexFour.neighbors = [Edge(neighbor: vertexThree, weight: 11.4),
                        Edge(neighbor: vertexFour, weight: 8.4)]

vertexFive.neighbors = [Edge(neighbor: rootVertex, weight: 10)]
```

</details>

```swift
func traverseGraph<T>(startingWith vertex: Vertex<T>) {
    var graphQueue = Queue<Vertex<T>>()
    graphQueue.enQueue(vertex)
    while !graphQueue.isEmpty {
        let currentVertex = graphQueue.deQueue()!
        print(currentVertex.key)
        currentVertex.visited = true
        for edge in currentVertex.neighbors {
            let neighbor = edge.neighbor
            if neighbor.visited == false {
                graphQueue.enQueue(edge.neighbor)
            }
        }
    }
}
```

## 5. Problem solving with graphs

[Project Euler](https://projecteuler.net/problem=15)

<details>
<summary>Point Struct</summary>

```swift

struct Point: Comparable, Hashable {
    static func <(lhs: Point, rhs: Point) -> Bool {
        return lhs.x < rhs.x || lhs.y < rhs.y
    }
    static func ==(lhs: Point, rhs: Point) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
    public var hashValue: Int {
        return x.hashValue ^ y.hashValue
    }
    let x: Int
    let y: Int
    static let zero = Point(x: 0, y: 0)
}


```

</details>


<details>
<summary>Solution</summary>

```swift
var pathDict = [Point: Int]()

func numberOfPaths(from startPoint: Point = Point.zero, to endPoint: Point) -> Int {
    if startPoint == endPoint { return 1 }
    if startPoint > endPoint { return 0 }
    let rightPoint = Point(x: startPoint.x + 1, y: startPoint.y)
    let downPoint = Point(x: startPoint.x, y: startPoint.y + 1)
    let numberOfRightPaths = pathDict[rightPoint, default: numberOfPaths(from: rightPoint, to: endPoint)]
    pathDict[rightPoint] = numberOfRightPaths
    let numberOfDownPaths = pathDict[downPoint, default: numberOfPaths(from: downPoint, to: endPoint)]
    pathDict[downPoint] = numberOfDownPaths
    return numberOfRightPaths + numberOfDownPaths
}

numberOfPaths(to: Point(x: 20, y: 20))
```

</details>

## 6. Graph/Tree Exercises


1. [Leetcode: Making change 1](https://leetcode.com/problems/coin-change/description/)
2. [Leetcode: Making change 2](https://leetcode.com/problems/coin-change-2/description/)
1. [Hackerrank: Shortest Graph Path](https://www.hackerrank.com/challenges/bfsshortreach/problem)
1. [Codewars: Character Selection](https://www.codewars.com/kata/5853213063adbd1b9b0000be/train/swift?collection=graph-1)
2. [Codewars: Character Selection 2](https://www.codewars.com/kata/street-fighter-2-character-selection-part-2/swift)


