# Tree (ADT) Data Structure 

In computer science, a tree is a widely used abstract data type (ADT)—or data structure implementing this ADT—that simulates a hierarchical tree structure, with a root value and subtrees of children with a parent node, represented as a set of linked nodes.

A tree data structure can be defined recursively as a collection of nodes (starting at a root node), where each node is a data structure consisting of a value, together with a list of references to nodes (the "children"), with the constraints that no reference is duplicated, and none points to the root.

![Tree Structure](https://koenig-media.raywenderlich.com/uploads/2016/06/Tree-2-650x300.png)  


Let's implement the following hierarchical tree structure in Swift 

![Animal Hierarchy](https://www.codeproject.com/KB/cs/42863/ContraCo_thumb_17_.gif)   

Basic TreeNode class, doen't have the ability to add children nodes yet, let's implement this next. 
```swift 
class TreeNode<T> {
  var value: T
  var parent: TreeNode?
  var children = [TreeNode]()
  
  init(value: T) {
    self.value = value
  }
}
```

Here we have added a addChild() method on the TreeNode class to have the ability to add children to the tree. 
```swift 
class TreeNode<T> {
  var value: T
  var parent: TreeNode?
  var children = [TreeNode]()
  
  init(value: T) {
    self.value = value
  }
  
  public func addChild(node: TreeNode) {
    children.append(node)
    node.parent = self
  }
}
```

We can now add children to our animal created Tree, however when we print our animal Tree the print console does not give us a human readeable print statement as seen below. We will have to conform to CustomStringConvertible and provide implement the **description** variable to return a more verbose string representing our current Tree structure.
```swift
class TreeNode<T> {
  var value: T
  var parent: TreeNode?
  var children = [TreeNode]()
  
  init(value: T) {
    self.value = value
  }
  
  public func addChild(node: TreeNode) {
    children.append(node)
    node.parent = self
  }
}

let tree = TreeNode<String>(value: "animal")
let mammalNode = TreeNode<String>(value: "mammal")
let reptileNode = TreeNode<String>(value: "reptile")
tree.children = [mammalNode, reptileNode]
print(tree) // __lldb_expr_23.TreeNode<Swift.String>
```

After conforming to CustomStringConvertible we can now get a more readable print statement representing the current animal Tree.
```swift 
class TreeNode<T>: CustomStringConvertible {
  var value: T
  var parent: TreeNode?
  var children = [TreeNode]()
  
  var description: String {
    guard !children.isEmpty else {
      return "\(value)"
    }
    return "\(value)" + "{" + "\(children.map{ $0.description }.joined(separator: ", ") )" + "}"
  }
  
  init(value: T) {
    self.value = value
  }
  
  public func addChild(node: TreeNode) {
    children.append(node)
    node.parent = self
  }
}

let tree = TreeNode<String>(value: "animal")
let mammalNode = TreeNode<String>(value: "mammal")
let reptileNode = TreeNode<String>(value: "reptile")
tree.children = [mammalNode, reptileNode]
print(tree) // animal{mammal, reptile}
```

**Full Tree Implemenation including Search**   
```swift 
class TreeNode<T: Equatable>: CustomStringConvertible {
  var value: T
  var parent: TreeNode?
  var children = [TreeNode]()
  
  var description: String {
    guard !children.isEmpty else {
      return "\(value)"
    }
    return "\(value)" + "{" + "\(children.map{ $0.description }.joined(separator: ", ") )" + "}"
  }
  
  init(value: T) {
    self.value = value
  }
  
  public func addChild(node: TreeNode) {
    children.append(node)
    node.parent = self
  }
  
  public func search(value: T) -> TreeNode? {
    if self.value == value {
      return self
    }
    for child in children {
      if let foundNode = child.search(value: value) {
        return foundNode
      }
    }
    return nil
  }
}

let tree = TreeNode<String>(value: "animal")

let mammalNode = TreeNode<String>(value: "mammal")
let reptileNode = TreeNode<String>(value: "reptile")

let giraffeNode = TreeNode<String>(value: "giraffe")
let tigerNode = TreeNode<String>(value: "tiger")

let snakeNode = TreeNode<String>(value: "snake")
let turtleNode = TreeNode<String>(value: "turtle")

tree.children = [mammalNode, reptileNode]
mammalNode.children = [giraffeNode, tigerNode]
reptileNode.children = [snakeNode, turtleNode]

print(tree) // animal{mammal{giraffe, tiger}, reptile{snake, turtle}}
```

The **height** of the Animal tree above is 2.     
The **depth** of the reptile node is 1.   


## Readings 
[Tree - Data Structure - Wikipedia](https://en.wikipedia.org/wiki/Tree_(data_structure))   
[Trees - Ray Wenderlich](https://github.com/raywenderlich/swift-algorithm-club/tree/master/Tree)    
