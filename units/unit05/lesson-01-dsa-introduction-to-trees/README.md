# Tree (ADT) Data Structure 

In computer science, a tree is a widely used abstract data type (ADT)—or data structure implementing this ADT—that simulates a hierarchical tree structure, with a root value and subtrees of children with a parent node, represented as a set of linked nodes.

A tree data structure can be defined recursively as a collection of nodes (starting at a root node), where each node is a data structure consisting of a value, together with a list of references to nodes (the "children"), with the constraints that no reference is duplicated, and none points to the root.

![Tree Structure](https://koenig-media.raywenderlich.com/uploads/2016/06/Tree-2-650x300.png)  


Let's implement the following hierarchical tree structure in Swift 

![Beverages Hierarchy](https://github.com/joinpursuit/Pursuit-Core-iOS/blob/master/units/unit05/lesson-01-dsa-introduction-to-trees/Images/beverages-tree.png)

Basic TreeNode class, doen't have the ability to add children nodes yet, let's implement this next. 
```swift 
class TreeNode<T: Equatable> {
  var value: T
  var children = [TreeNode]()
  var parent: TreeNode?
  init(_ value: T) {
    self.value = value
  }
}
```

Here we have added a addChild() method on the TreeNode class to have the ability to add children to the tree. 
```swift 
class TreeNode<T: Equatable> {
  var value: T
  var children = [TreeNode]()
  var parent: TreeNode?
  init(_ value: T) {
    self.value = value
  }
  
  // adding a child node
  public func addChild(_ child: TreeNode) {
    children.append(child)
    child.parent = self
  }
}
```

**Queue is used to implement level-Order traversal** 
```swift
public struct Queue<T> {
  private var items = [T]()
  public var isEmpty: Bool {
    return items.isEmpty
  }
  public var peek: T? {
    return items.first
  }
  @discardableResult
  mutating public func enqueue(_ element: T) -> Bool {
    items.append(element)
    return true
  }
  mutating public func dequeue() -> T? {
    guard items.count > 0 else { return nil }
    return items.removeFirst()
  }
}
```

**Full Tree Implemenation**   
```swift 
class TreeNode<T: Equatable> {
  var value: T
  var children = [TreeNode]()
  var parent: TreeNode?
  init(_ value: T) {
    self.value = value
  }
  
  // adding a child node
  public func addChild(_ child: TreeNode) {
    children.append(child)
    child.parent = self
  }
  
  // traversal - the way in which we visit each node in the tree
  
  // level-order traversal - walking the tree in order of tree level
  // A Queue is used to keep track of the child nodes to be visited in order of level
  // We use a closure to capture the value of the visited node
  public func levelOrderTraversal(visit: (TreeNode) -> Void) {
    // We first visit the parent node
    visit(self)
    // We create an empty Queue to hold the children nodes of the parent
    var queue = Queue<TreeNode>()
    // We visit each child node of the parent and store it in the Queue
    children.forEach { queue.enqueue($0) }
    // Each child is dequeueed and visited in the order in which they were enqueued using a while loop
    while let node = queue.dequeue() {
      // node is visited first
      visit(node)
      // child nodes are enqueued to be visited in order
      node.children.forEach { queue.enqueue($0) }
    }
  }
  
  // depth-order traversal - here we visit the parent node then it's children, then the child's children recursively
  // we use a closure to capture the visited node
  public func depthOrderTraversal(visit: (TreeNode) -> Void) {
    visit(self)
    children.forEach { $0.depthOrderTraversal(visit: visit) }
  }
  
  // search
  // here we are using levelOrderTraversal() to search for a given value
  public func search(_ value: T) -> Bool {
    var isFound = false
    levelOrderTraversal { (node) in
      if node.value == value {
        isFound = true
      }
    }
    return isFound
  }
}

// testing the tree using a hierarchical representation of beverages
let beverages = TreeNode<String>("beverages")
let hot = TreeNode<String>("hot")
let cold = TreeNode<String>("cold")
beverages.addChild(hot)
beverages.addChild(cold)

let tea = TreeNode<String>("tea")
let coffee = TreeNode<String>("coffee")
let chocolate = TreeNode<String>("chocolate")
hot.addChild(tea)
hot.addChild(coffee)
hot.addChild(chocolate)

let black = TreeNode<String>("black")
let green = TreeNode<String>("green")
let chai = TreeNode<String>("chai")
tea.addChild(black)
tea.addChild(green)
tea.addChild(chai)

let soda = TreeNode<String>("soda")
let milk = TreeNode<String>("milk")
cold.addChild(soda)
cold.addChild(milk)

let gingerAle = TreeNode<String>("gingerAle")
let coke = TreeNode<String>("coke")
soda.addChild(gingerAle)
soda.addChild(coke)


// level order traversal
print("level-order traversal: ")
beverages.levelOrderTraversal { (node) in
  print(node.value, terminator: " ")
}
// beverages hot cold tea coffee chocolate soda milk black green chai gingerAle coke

print("\n")

// depth order traversal
print("depth-order traversal: ")
beverages.depthOrderTraversal { (node) in
  print(node.value, terminator: " ")
}
// beverages hot tea black green chai coffee chocolate cold soda gingerAle coke milk

print("\n\nsearching....")

// search
if beverages.search("coke") {
  print("your beverage is coming right up")
} else {
  print("sorry your beverage is not on the menu")
}

```

## Readings 
[Tree - Data Structure - Wikipedia](https://en.wikipedia.org/wiki/Tree_(data_structure))   
[Trees - Ray Wenderlich](https://github.com/raywenderlich/swift-algorithm-club/tree/master/Tree)    

**Exercise - Create the following Tree, search and print the Primate Node**  
![Exercise](https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRjQW-1pjHGITkZN8UU99M566cbJPtA1WxeU2KkH4AK0ofZPNPK)   
