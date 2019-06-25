# Binary Search Tree

## Binary Tree

A tree whose elements have at most 2 children is called a binary tree. Since each element in a binary tree can have only 2 children, we typically name them the left and right child.

![binary tree](https://www.geeksforgeeks.org/wp-content/uploads/binary-tree-to-DLL.png)

## Binary Search Tree

In computer science, binary search trees (BST), sometimes called ordered or sorted binary trees, are a particular type of container: data structures that store "items" (such as numbers, names etc.) in memory. They allow fast lookup, addition and removal of items, and can be used to implement either dynamic sets of items, or lookup tables that allow finding an item by its key (e.g., finding the phone number of a person by name).

Binary search trees keep their keys in sorted order, so that lookup and other operations can use the principle of binary search: when looking for a key in a tree (or a place to insert a new key), they traverse the tree from root to leaf, making comparisons to keys stored in the nodes of the tree and deciding, on the basis of the comparison, to continue searching in the left or right subtrees. On average, this means that each comparison allows the operations to skip about half of the tree, so that each lookup, insertion or deletion takes time proportional to the logarithm of the number of items stored in the tree. This is much better than the linear time required to find items by key in an (unsorted) array, but slower than the corresponding operations on hash tables.

![binary search tree](https://cdncontribute.geeksforgeeks.org/wp-content/uploads/BSTSearch.png)

A Binary Search Tree needs to adhere to the following properties: 
- The left subtree of a node contains only nodes with keys lesser than the node’s key.
- The right subtree of a node contains only nodes with keys greater than the node’s key.
- The left and right subtree each must also be a binary search tree.

## Readings 

[Wikipedia - Binary Search Tree](https://en.wikipedia.org/wiki/Binary_search_tree)    
[GeeksforGeeks - Binary Search Tree](https://www.geeksforgeeks.org/binary-search-tree-data-structure/)   
[Ray Wenderlich - Binary Search Tree](https://github.com/raywenderlich/swift-algorithm-club/tree/master/Binary%20Search%20Tree)     
[Stackoverflow - What are the applications of binary trees](https://stackoverflow.com/questions/2130416/what-are-the-applications-of-binary-trees)     

## Traversing a Binary Tree 

There are three ways to traverse a binary tree:

- In-order (or depth-first): first look at the left child of a node then at the node itself and finally at its right child.
- Pre-order: first look at a node then its left and right children.
- Post-order: first look at the left and right children and process the node itself last.


## Implementation 

```swift 
/*
 Binary Search Tree:
 - node to the left is less than root
 - node to the right is more than root
 - searching O(log n)
 
 Objectives:
 - implement a binary search tree
 - implement insert
 - implement search
 - implement remove
 
 
                  10
                /    \
              2      12
            /       /  \
           0       11  15
*/

class BinaryNode<T: Equatable>: Equatable {
  var value: T
  var leftChild: BinaryNode?
  var rightChild: BinaryNode?
  init(_ value: T) {
    self.value = value
  }
  public static func ==(lhs: BinaryNode, rhs: BinaryNode) -> Bool {
    return lhs.value == rhs.value &&
      lhs.leftChild == rhs.leftChild &&
      lhs.rightChild == rhs.rightChild
  }
  // in-order
  public func inOrderTraversal(visit:(BinaryNode) -> Void) {
    leftChild?.inOrderTraversal(visit: visit)
    visit(self)
    rightChild?.inOrderTraversal(visit: visit)
  }
  
  // pre-order
  
  // post-order
}

public struct BinarySearchTree<T: Comparable> {
  private var root: BinaryNode<T>?
  
  public func printInOrderTraversal() {
    root?.inOrderTraversal(visit: { (node) in
      print(node.value)
    })
  }
  
  // insert
  public mutating func insert(_ value: T) {
    root = insert(from: root, value: value)
  }
  private func insert(from node: BinaryNode<T>?, value: T) -> BinaryNode<T> {
    // first check if the tree is empty
    guard let node = node else {
      return BinaryNode(value) // if not create a new node and return it
    }
    // tree exist
    if value < node.value {
      // recursively call insert() as long as value is less than current node's value
      node.leftChild = insert(from: node.leftChild, value: value)
    } else {
      // recursively call insert() as long as value is more than current node's value
      node.rightChild = insert(from: node.rightChild, value: value)
    }
    return node
  }
  
  // search
  public func search(_ value: T) -> Bool {
    var current = root
    while let node = current {
      if value == node.value {
        return true
      }
      else if value < node.value {
        current = node.leftChild
      } else {
        current = node.rightChild
      }
    }
    return false
  }
  
  // remove
  public mutating func remove(_ value: T) {
    root = remove(from: root, value: value)
  }
  private func remove(from node: BinaryNode<T>?, value: T) -> BinaryNode<T>? {
    // is tree empty
    guard let node = node else { return nil }
    
    // did we find the node to be removed
    if value == node.value {
      if node.leftChild == nil && node.rightChild == nil { // node has no children, just simply remove, return nil
        return nil
      }
      if node.leftChild == nil { // only has right child
        return node.rightChild
      }
      if node.rightChild == nil { // only has left child
        return node.leftChild
      }
      /*
       e.g below if we're removing 12,
       1. 14 will be swapped in 12's place
       2. we need recursively search and remove 14
                            10
                          /   \
                         2    12
                        /    /  \
                       0    11   15
                                /
                              14
      */
      // here the node has a left and right child
      // we first replace the node's value with the min value from the right subtree
      node.value = node.rightChild!.min.value
      // then we recurvisely find and remove the swapped value from above
      node.rightChild = remove(from: node.rightChild, value: node.value)
    } else if value < node.value {
      node.leftChild = remove(from: node.leftChild, value: value)
    } else {
      node.rightChild = remove(from: node.rightChild, value: value)
    }
    return node
  }
}

// extensive on BinaryNode recursivley finds the min value of a subtree
extension BinaryNode {
  var min: BinaryNode {
    return leftChild?.min ?? self
  }
}

var tree = BinarySearchTree<Int>()
tree.insert(10)
tree.insert(2)
tree.insert(12)
tree.insert(0)
tree.insert(11)
tree.insert(15)

tree.printInOrderTraversal() // 0, 2, 10, 11, 12, 15
tree.search(11) // true
tree.search(1) // false
tree.insert(14)

print()
tree.printInOrderTraversal() // 0, 2, 10, 11, 12, 14, 15
tree.remove(12)

print()
tree.printInOrderTraversal() // 0, 2, 10, 11, 14, 15
```
