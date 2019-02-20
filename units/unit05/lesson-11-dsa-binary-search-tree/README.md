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
// Binary Search Tree

/*
 - left child's value is less than parent's (root) value
 - right child's value is more than parent's (root) value
 - holds the principles of a binary tree where any child at most has 2 children
*/


// Our Binary Search Tree example
/*
 
          8
        /  \
      3     10
    /  \      \
   1    6      14
      /   \    /
    4      7  13
 
*/

// Implementation

// Generic Binary Search Tree
class TreeNode<T: Comparable> {
  var value: T
  var leftChild: TreeNode<T>?
  var rightChild: TreeNode<T>?
  
  init(value: T, leftChild: TreeNode<T>?, rightChild: TreeNode<T>?) {
    self.value = value
    self.leftChild = leftChild
    self.rightChild = rightChild
  }
}

// Construct the tree illustrated above, (bottom up)

// left side
let fourNode = TreeNode(value: 4, leftChild: nil, rightChild: nil)
let sevenNode = TreeNode(value: 7, leftChild: nil, rightChild: nil)
let sixNode = TreeNode(value: 6, leftChild: fourNode, rightChild: sevenNode)
let oneNoce = TreeNode(value: 1, leftChild: nil, rightChild: nil)
let threeNode = TreeNode(value: 3, leftChild: oneNoce, rightChild: sixNode)


// right side
let thirteenNode = TreeNode(value: 13, leftChild: nil, rightChild: nil)
let fourteenNode = TreeNode(value: 14, leftChild: thirteenNode, rightChild: nil)
let tenNode = TreeNode(value: 10, leftChild: nil, rightChild: fourteenNode)

// parent (root) node
let parentNode = TreeNode(value: 8, leftChild: threeNode, rightChild: tenNode)

// searching the tree
func searchBinaryTree<T: Comparable>(searchValue: T, treeNode: TreeNode<T>?) -> Bool {
  if treeNode?.value == searchValue {
    return true
  }
  if treeNode == nil {
    return false
  }
  else {
    if searchValue < treeNode!.value { // look at the left child
      return searchBinaryTree(searchValue: searchValue, treeNode: treeNode?.leftChild)
    } else { // look at the right child
      return searchBinaryTree(searchValue: searchValue, treeNode: treeNode?.rightChild)
    }
  }
}

// test
searchBinaryTree(searchValue: 14, treeNode: parentNode) // true
searchBinaryTree(searchValue: 9, treeNode: parentNode) // false
```
